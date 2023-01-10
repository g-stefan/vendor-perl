// Created by Grigore Stefan <g_stefan@yahoo.com>
// Public domain (Unlicense) <http://unlicense.org>
// SPDX-FileCopyrightText: 2022-2023 Grigore Stefan <g_stefan@yahoo.com>
// SPDX-License-Identifier: Unlicense

Fabricare.include("vendor");

messageAction("make");

if (Shell.fileExists("temp/build.done.flag")) {
	return;
};

if (!Shell.directoryExists("source")) {
	exitIf(Shell.system("7z x -aoa archive/" + Project.vendor + ".7z"));
	Shell.rename(Project.vendor, "source");
};

Shell.mkdirRecursivelyIfNotExists("output");
Shell.mkdirRecursivelyIfNotExists("output/bin");
Shell.mkdirRecursivelyIfNotExists("output/lib");
Shell.mkdirRecursivelyIfNotExists("temp");

if (Platform.name.indexOf("win64") >= 0) {
	Shell.copyFile("fabricare/source/Makefile.msvc64", "source/win32/Makefile");
}else{
	Shell.copyFile("fabricare/source/Makefile.msvc32", "source/win32/Makefile");
};

var outputPath=Shell.getcwd()+"\\output";

runInPath("source\\win32",function(){
	exitIf(Shell.system("nmake -f Makefile INST_DRV=\""+outputPath+"\""));
	exitIf(Shell.system("nmake -f Makefile INST_DRV=\""+outputPath+"\" install"));
});

Shell.filePutContents("temp/build.done.flag", "done");
