// Created by Grigore Stefan <g_stefan@yahoo.com>
// Public domain (Unlicense) <http://unlicense.org>
// SPDX-FileCopyrightText: 2022 Grigore Stefan <g_stefan@yahoo.com>
// SPDX-License-Identifier: Unlicense

messageAction("clean");

forceRemoveDirRecursively("output");
Shell.removeDirRecursively("temp");
forceRemoveDirRecursively("source");

