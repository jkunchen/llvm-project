//===-- Cpu0.td - Describe the Cpu0 Target Machine -----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Target-independent interfaces which we are implementing
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

//===----------------------------------------------------------------------===//
// Target-dependent interfaces
//===----------------------------------------------------------------------===//

// Register Infomation
include "Cpu0RegisterInfo.td"

// Calling Conversion
include "Cpu0Schedule.td"

// Instruction Description
include "Cpu0InstrInfo.td"

//===----------------------------------------------------------------------===//
// Cpu0 SUbtarget features
//===----------------------------------------------------------------------===//

def FeatureCmp      : SubtargetFeature<"cmp", "HasCmp", "true",
                                       "Enable 'cmp' instructions.">;
def FeatureSlt      : SubtargetFeature<"slt", "HasSlt", "true",
                                       "Enable 'slt' instructions.">;
def FeatureCpu032I  : SubtargetFeature<"cpu032I", "Cpu0ArchVersion",
                                       "Cpu032I", "Cpu032I ISA Support",
                                       [FeatureCmp]>;
def FeatureCpu032II : SubtargetFeature<"cpu032II", "Cpu0ArchVersion",
                                       "Cpu032II", "Cpu032II ISA Support",
                                       [FeatureCmp, FeatureSlt]>;

//===----------------------------------------------------------------------===//
// Cpu0 processors supported
//===----------------------------------------------------------------------===//
class Proc<string Name, list<SubtargetFeature> Features>
  : Processor<Name, Cpu0GenericItineraries, Features>;

def : Proc<"cpu032I", [FeatureCpu032I]>;
def : Proc<"cpu032II", [FeatureCpu032II]>;

def Cpu0InstrInfo : InstrInfo;

// Will generate Cpu0GenAsmWrite.inc included by Cpu0InstPrinter.cpp, contents
// as follows,
// void Cpu0InstPrinter::printInstruction(const MCInst *MI, raw_ostream &O) {...}
// const char* Cpu0InstPrinter::getRegisterName(unsigned RegNo) {...}
def Cpu0 : Target {
  let InstructionSet = Cpu0InstrInfo;
}
