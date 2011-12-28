# Robotlegs Migration Extension

This extension helps you migrate Robotlegs v1.x applications over to v2.x by providing a set of v1.x implementations that delegate to their v2.x counterparts. It aims to get your old apps up and running against v2 quickly and easily, but should only be used as a temporary solution while you migrate your legacy code.

## Installation

1. Download and install Robotlegs v2.x
2. Drop the robotlegs-migration-extension SWC into your libs folder
3. Install the extension into your Context Builder

        context = new ContextBuilder()
            .withBundle(ClassicRobotlegsBundle)
            .withExtension(MigrationExtension)
            .withConfig(MyApplicationConfig)
            .build();

# License

The MIT License

Copyright (c) 2011, 2012 the original author or authors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.