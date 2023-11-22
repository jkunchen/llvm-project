add_llvm_component_group(Cpu0 HAS_JIT)

set(LLVM_TARGET_DEFINITIONS Cpu0.td)

tablegen(LLVM Cpu0GenRegisterInfo.inc -gen-register-info)
tablegen(LLVM Cpu0GenInstrInfo.inc -gen-instr-info)
tablegen(LLVM Cpu0GenSubtargetInfo.inc -gen-subtarget)
tablegen(LLVM Cpu0GenMCPseudoLowering.inc -gen-pseudo-lowering)

# Cpu0CommonTableGen must be defined
add_public_tablegen_target(Cpu0CommonTableGen)

add_llvm_target(Cpu0CodeGen
  Cpu0TargetMachine.cpp

  LINK_COMPONENTS
  Analysis
  AsmPrinter
  CodeGen
  CodeGenTypes
  Core
  GlobalISel
  MC
  Cpu0Desc
  Cpu0Info
  SelectionDAG
  Support
  Target
  TargetParser

  ADD_TO_COMPONENT
  Cpu0
  )

add_subdirectory(MCTargetDesc)
add_subdirectory(TargetInfo)
