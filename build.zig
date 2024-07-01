const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const arm = b.option(bool, "arm", "Controls -DCAPSTONE_HAS_ARM") orelse false;
    const arm64 = b.option(bool, "arm64", "Controls -DCAPSTONE_HAS_ARM64") orelse false;
    const mips = b.option(bool, "mips", "Controls -DCAPSTONE_HAS_MIPS") orelse false;
    const powerpc = b.option(bool, "powerpc", "Controls -DCAPSTONE_HAS_POWERPC") orelse false;
    const x86 = b.option(bool, "x86", "Controls -DCAPSTONE_HAS_X86") orelse false;
    const sparc = b.option(bool, "sparc", "Controls -DCAPSTONE_HAS_SPARC") orelse false;
    const sysz = b.option(bool, "sysz", "Controls -DCAPSTONE_HAS_SYSZ") orelse false;
    const xcore = b.option(bool, "xcore", "Controls -DCAPSTONE_HAS_XCORE") orelse false;
    const m68k = b.option(bool, "m68k", "Controls -DCAPSTONE_HAS_M68K") orelse false;
    const tms320c64x = b.option(bool, "tms320c64x", "Controls -DCAPSTONE_HAS_TMS320C64X") orelse false;
    const m680x = b.option(bool, "m680x", "Controls -DCAPSTONE_HAS_M680X") orelse false;
    const evm = b.option(bool, "evm", "Controls -DCAPSTONE_HAS_EVM") orelse false;
    const wasm = b.option(bool, "wasm", "Controls -DCAPSTONE_HAS_WASM") orelse false;
    const mos65xx = b.option(bool, "mos65xx", "Controls -DCAPSTONE_HAS_MOS65XX") orelse false;
    const bpf = b.option(bool, "bpf", "Controls -DCAPSTONE_HAS_BPF") orelse false;
    const riscv = b.option(bool, "riscv", "Controls -DCAPSTONE_HAS_RISCV") orelse false;
    const sh = b.option(bool, "sh", "Controls -DCAPSTONE_HAS_SH") orelse false;
    const tricore = b.option(bool, "tricore", "Controls -DCAPSTONE_HAS_TRICORE") orelse false;

    const upstream = b.dependency("capstone", .{});
    const lib = b.addSharedLibrary(.{
        .name = "capstone",
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.addIncludePath(upstream.path("include"));
    lib.addCSourceFiles(.{
        .root = upstream.path(""),
        .files = &.{
            "Mapping.c",
            "MCInst.c",
            "cs.c",
            "MCInstrDesc.c",
            "utils.c",
            "SStream.c",
            "MCRegisterInfo.c",

            "cstool/cstool_evm.c",
            "cstool/cstool_systemz.c",
            "cstool/getopt.c",
            "cstool/cstool_arm64.c",
            "cstool/cstool_tricore.c",
            "cstool/cstool_powerpc.c",
            "cstool/cstool_mips.c",
            "cstool/cstool_x86.c",
            "cstool/cstool_mos65xx.c",
            "cstool/cstool_bpf.c",
            "cstool/cstool.c",
            "cstool/cstool_riscv.c",
            "cstool/cstool_sparc.c",
            "cstool/cstool_m68k.c",
            "cstool/cstool_xcore.c",
            "cstool/cstool_sh.c",
            "cstool/cstool_tms320c64x.c",
            "cstool/cstool_arm.c",
            "cstool/cstool_wasm.c",
            "cstool/cstool_m680x.c",

            "arch/PowerPC/PPCModule.c",
            "arch/PowerPC/PPCMapping.c",
            "arch/PowerPC/PPCDisassembler.c",
            "arch/PowerPC/PPCInstPrinter.c",
            "arch/X86/X86IntelInstPrinter.c",
            "arch/X86/X86DisassemblerDecoder.c",
            "arch/X86/X86InstPrinterCommon.c",
            "arch/X86/X86Mapping.c",
            "arch/X86/X86Disassembler.c",
            "arch/X86/X86Module.c",
            "arch/X86/X86ATTInstPrinter.c",
            "arch/M680X/M680XInstPrinter.c",
            "arch/M680X/M680XDisassembler.c",
            "arch/M680X/M680XModule.c",
            "arch/TMS320C64x/TMS320C64xModule.c",
            "arch/TMS320C64x/TMS320C64xInstPrinter.c",
            "arch/TMS320C64x/TMS320C64xMapping.c",
            "arch/TMS320C64x/TMS320C64xDisassembler.c",
            "arch/XCore/XCoreDisassembler.c",
            "arch/XCore/XCoreMapping.c",
            "arch/XCore/XCoreInstPrinter.c",
            "arch/XCore/XCoreModule.c",
            "arch/MOS65XX/MOS65XXDisassembler.c",
            "arch/MOS65XX/MOS65XXModule.c",
            "arch/BPF/BPFDisassembler.c",
            "arch/BPF/BPFMapping.c",
            "arch/BPF/BPFInstPrinter.c",
            "arch/BPF/BPFModule.c",
            "arch/Sparc/SparcInstPrinter.c",
            "arch/Sparc/SparcMapping.c",
            "arch/Sparc/SparcDisassembler.c",
            "arch/Sparc/SparcModule.c",
            "arch/WASM/WASMModule.c",
            "arch/WASM/WASMInstPrinter.c",
            "arch/WASM/WASMDisassembler.c",
            "arch/WASM/WASMMapping.c",
            "arch/Mips/MipsInstPrinter.c",
            "arch/Mips/MipsDisassembler.c",
            "arch/Mips/MipsMapping.c",
            "arch/Mips/MipsModule.c",
            "arch/SystemZ/SystemZInstPrinter.c",
            "arch/SystemZ/SystemZDisassembler.c",
            "arch/SystemZ/SystemZMCTargetDesc.c",
            "arch/SystemZ/SystemZModule.c",
            "arch/SystemZ/SystemZMapping.c",
            "arch/RISCV/RISCVMapping.c",
            "arch/RISCV/RISCVDisassembler.c",
            "arch/RISCV/RISCVInstPrinter.c",
            "arch/RISCV/RISCVModule.c",
            "arch/SH/SHInstPrinter.c",
            "arch/SH/SHModule.c",
            "arch/SH/SHDisassembler.c",
            "arch/ARM/ARMInstPrinter.c",
            "arch/ARM/ARMMapping.c",
            "arch/ARM/ARMDisassembler.c",
            "arch/ARM/ARMModule.c",
            "arch/M68K/M68KInstPrinter.c",
            "arch/M68K/M68KModule.c",
            "arch/M68K/M68KDisassembler.c",
            "arch/AArch64/AArch64BaseInfo.c",
            "arch/AArch64/AArch64Module.c",
            "arch/AArch64/AArch64InstPrinter.c",
            "arch/AArch64/AArch64Mapping.c",
            "arch/AArch64/AArch64Disassembler.c",
            "arch/TriCore/TriCoreModule.c",
            "arch/TriCore/TriCoreInstPrinter.c",
            "arch/TriCore/TriCoreMapping.c",
            "arch/TriCore/TriCoreDisassembler.c",
            "arch/EVM/EVMModule.c",
            "arch/EVM/EVMInstPrinter.c",
            "arch/EVM/EVMMapping.c",
            "arch/EVM/EVMDisassembler.c",
        },
        .flags = &.{
            // For now, let's just add all of them lol
            if (arm) "-DCAPSTONE_HAS_ARM" else "",
            if (arm64) "-DCAPSTONE_HAS_ARM64" else "",
            if (mips) "-DCAPSTONE_HAS_MIPS" else "",
            if (powerpc) "-DCAPSTONE_HAS_POWERPC" else "",
            if (x86) "-DCAPSTONE_HAS_X86" else "",
            if (sparc) "-DCAPSTONE_HAS_SPARC" else "",
            if (sysz) "-DCAPSTONE_HAS_SYSZ" else "",
            if (xcore) "-DCAPSTONE_HAS_XCORE" else "",
            if (m68k) "-DCAPSTONE_HAS_M68K" else "",
            if (tms320c64x) "-DCAPSTONE_HAS_TMS320C64X" else "",
            if (m680x) "-DCAPSTONE_HAS_M680X" else "",
            if (evm) "-DCAPSTONE_HAS_EVM" else "",
            if (wasm) "-DCAPSTONE_HAS_WASM" else "",
            if (mos65xx) "-DCAPSTONE_HAS_MOS65XX" else "",
            if (bpf) "-DCAPSTONE_HAS_BPF" else "",
            if (riscv) "-DCAPSTONE_HAS_RISCV" else "",
            if (sh) "-DCAPSTONE_HAS_SH" else "",
            if (tricore) "-DCAPSTONE_HAS_TRICORE" else "",
        },
    });

    lib.installHeadersDirectory(upstream.path("include"), "", .{});

    b.installArtifact(lib);
}
