//===-- llvm/CodeGen/DIEHash.h - Dwarf Hashing Framework -------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains support for DWARF4 hashing of DIEs.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_CODEGEN_ASMPRINTER_DIEHASH_H
#define LLVM_LIB_CODEGEN_ASMPRINTER_DIEHASH_H

#include "llvm/ADT/DenseMap.h"
#include "llvm/CodeGen/DIE.h"
#include "llvm/Support/MD5.h"

namespace llvm {

class AsmPrinter;
class CompileUnit;

/// \brief An object containing the capability of hashing and adding hash
/// attributes onto a DIE.
class DIEHash {
  // Collection of all attributes used in hashing a particular DIE.
  struct DIEAttrs {
#define HANDLE_DIE_HASH_ATTR(NAME) DIEValue NAME;
#include "DIEHashAttributes.def"
  };

public:
  DIEHash(AsmPrinter *A = nullptr) : AP(A) {}

  /// \brief Computes the CU signature.
  uint64_t computeCUSignature(const DIE &Die);

  /// \brief Computes the type signature.
  uint64_t computeTypeSignature(const DIE &Die);

  // Helper routines to process parts of a DIE.
private:
  /// \brief Adds the parent context of \param Die to the hash.
  void addParentContext(const DIE &Die);

  /// \brief Adds the attributes of \param Die to the hash.
  void addAttributes(const DIE &Die);

  /// \brief Computes the full DWARF4 7.27 hash of the DIE.
  void computeHash(const DIE &Die);

  // Routines that add DIEValues to the hash.
public:
  /// \brief Adds \param Value to the hash.
  void update(uint8_t Value) { Hash.update(Value); }

  /// \brief Encodes and adds \param Value to the hash as a ULEB128.
  void addULEB128(uint64_t Value);

  /// \brief Encodes and adds \param Value to the hash as a SLEB128.
  void addSLEB128(int64_t Value);

private:
  /// \brief Adds \param Str to the hash and includes a NULL byte.
  void addString(StringRef Str);

  /// \brief Collects the attributes of DIE \param Die into the \param Attrs
  /// structure.
  void collectAttributes(const DIE &Die, DIEAttrs &Attrs);

  /// \brief Hashes the attributes in \param Attrs in order.
  void hashAttributes(const DIEAttrs &Attrs, dwarf::Tag Tag);

  /// \brief Hashes the data in a block like DIEValue, e.g. DW_FORM_block or
  /// DW_FORM_exprloc.
  void hashBlockData(const DIE::const_value_range &Values);

  /// \brief Hashes the contents pointed to in the .debug_loc section.
  void hashLocList(const DIELocList &LocList);

  /// \brief Hashes an individual attribute.
  void hashAttribute(const DIEValue &Value, dwarf::Tag Tag);

  /// \brief Hashes an attribute that refers to another DIE.
  void hashDIEEntry(dwarf::Attribute Attribute, dwarf::Tag Tag,
                    const DIE &Entry);

  /// \brief Hashes a reference to a named type in such a way that is
  /// independent of whether that type is described by a declaration or a
  /// definition.
  void hashShallowTypeReference(dwarf::Attribute Attribute, const DIE &Entry,
                                StringRef Name);

  /// \brief Hashes a reference to a previously referenced type DIE.
  void hashRepeatedTypeReference(dwarf::Attribute Attribute,
                                 unsigned DieNumber);

  void hashNestedType(const DIE &Die, StringRef Name);

private:
  MD5 Hash;
  AsmPrinter *AP;
  DenseMap<const DIE *, unsigned> Numbering;
};
}

#endif
