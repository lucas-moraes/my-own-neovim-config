"use strict";
var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __commonJS = (cb, mod) => function __require() {
  return mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
  // If the importer is in node compatibility mode or this is not an ESM
  // file that has been converted to a CommonJS file using a Babel-
  // compatible transform (i.e. "__esModule" has not been set), then set
  // "default" to the CommonJS "module.exports" for node compatibility.
  isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
  mod
));

// node_modules/isexe/windows.js
var require_windows = __commonJS({
  "node_modules/isexe/windows.js"(exports2, module2) {
    module2.exports = isexe;
    isexe.sync = sync;
    var fs2 = require("fs");
    function checkPathExt(path, options2) {
      var pathext = options2.pathExt !== void 0 ? options2.pathExt : process.env.PATHEXT;
      if (!pathext) {
        return true;
      }
      pathext = pathext.split(";");
      if (pathext.indexOf("") !== -1) {
        return true;
      }
      for (var i = 0; i < pathext.length; i++) {
        var p = pathext[i].toLowerCase();
        if (p && path.substr(-p.length).toLowerCase() === p) {
          return true;
        }
      }
      return false;
    }
    function checkStat(stat, path, options2) {
      if (!stat.isSymbolicLink() && !stat.isFile()) {
        return false;
      }
      return checkPathExt(path, options2);
    }
    function isexe(path, options2, cb) {
      fs2.stat(path, function(er, stat) {
        cb(er, er ? false : checkStat(stat, path, options2));
      });
    }
    function sync(path, options2) {
      return checkStat(fs2.statSync(path), path, options2);
    }
  }
});

// node_modules/isexe/mode.js
var require_mode = __commonJS({
  "node_modules/isexe/mode.js"(exports2, module2) {
    module2.exports = isexe;
    isexe.sync = sync;
    var fs2 = require("fs");
    function isexe(path, options2, cb) {
      fs2.stat(path, function(er, stat) {
        cb(er, er ? false : checkStat(stat, options2));
      });
    }
    function sync(path, options2) {
      return checkStat(fs2.statSync(path), options2);
    }
    function checkStat(stat, options2) {
      return stat.isFile() && checkMode(stat, options2);
    }
    function checkMode(stat, options2) {
      var mod = stat.mode;
      var uid = stat.uid;
      var gid = stat.gid;
      var myUid = options2.uid !== void 0 ? options2.uid : process.getuid && process.getuid();
      var myGid = options2.gid !== void 0 ? options2.gid : process.getgid && process.getgid();
      var u = parseInt("100", 8);
      var g = parseInt("010", 8);
      var o = parseInt("001", 8);
      var ug = u | g;
      var ret = mod & o || mod & g && gid === myGid || mod & u && uid === myUid || mod & ug && myUid === 0;
      return ret;
    }
  }
});

// node_modules/isexe/index.js
var require_isexe = __commonJS({
  "node_modules/isexe/index.js"(exports2, module2) {
    var fs2 = require("fs");
    var core;
    if (process.platform === "win32" || global.TESTING_WINDOWS) {
      core = require_windows();
    } else {
      core = require_mode();
    }
    module2.exports = isexe;
    isexe.sync = sync;
    function isexe(path, options2, cb) {
      if (typeof options2 === "function") {
        cb = options2;
        options2 = {};
      }
      if (!cb) {
        if (typeof Promise !== "function") {
          throw new TypeError("callback not provided");
        }
        return new Promise(function(resolve, reject) {
          isexe(path, options2 || {}, function(er, is) {
            if (er) {
              reject(er);
            } else {
              resolve(is);
            }
          });
        });
      }
      core(path, options2 || {}, function(er, is) {
        if (er) {
          if (er.code === "EACCES" || options2 && options2.ignoreErrors) {
            er = null;
            is = false;
          }
        }
        cb(er, is);
      });
    }
    function sync(path, options2) {
      try {
        return core.sync(path, options2 || {});
      } catch (er) {
        if (options2 && options2.ignoreErrors || er.code === "EACCES") {
          return false;
        } else {
          throw er;
        }
      }
    }
  }
});

// node_modules/cross-spawn/node_modules/which/which.js
var require_which = __commonJS({
  "node_modules/cross-spawn/node_modules/which/which.js"(exports2, module2) {
    var isWindows = process.platform === "win32" || process.env.OSTYPE === "cygwin" || process.env.OSTYPE === "msys";
    var path = require("path");
    var COLON = isWindows ? ";" : ":";
    var isexe = require_isexe();
    var getNotFoundError = (cmd) => Object.assign(new Error(`not found: ${cmd}`), { code: "ENOENT" });
    var getPathInfo = (cmd, opt) => {
      const colon = opt.colon || COLON;
      const pathEnv = cmd.match(/\//) || isWindows && cmd.match(/\\/) ? [""] : [
        // windows always checks the cwd first
        ...isWindows ? [process.cwd()] : [],
        ...(opt.path || process.env.PATH || /* istanbul ignore next: very unusual */
        "").split(colon)
      ];
      const pathExtExe = isWindows ? opt.pathExt || process.env.PATHEXT || ".EXE;.CMD;.BAT;.COM" : "";
      const pathExt = isWindows ? pathExtExe.split(colon) : [""];
      if (isWindows) {
        if (cmd.indexOf(".") !== -1 && pathExt[0] !== "")
          pathExt.unshift("");
      }
      return {
        pathEnv,
        pathExt,
        pathExtExe
      };
    };
    var which = (cmd, opt, cb) => {
      if (typeof opt === "function") {
        cb = opt;
        opt = {};
      }
      if (!opt)
        opt = {};
      const { pathEnv, pathExt, pathExtExe } = getPathInfo(cmd, opt);
      const found = [];
      const step = (i) => new Promise((resolve, reject) => {
        if (i === pathEnv.length)
          return opt.all && found.length ? resolve(found) : reject(getNotFoundError(cmd));
        const ppRaw = pathEnv[i];
        const pathPart = /^".*"$/.test(ppRaw) ? ppRaw.slice(1, -1) : ppRaw;
        const pCmd = path.join(pathPart, cmd);
        const p = !pathPart && /^\.[\\\/]/.test(cmd) ? cmd.slice(0, 2) + pCmd : pCmd;
        resolve(subStep(p, i, 0));
      });
      const subStep = (p, i, ii) => new Promise((resolve, reject) => {
        if (ii === pathExt.length)
          return resolve(step(i + 1));
        const ext = pathExt[ii];
        isexe(p + ext, { pathExt: pathExtExe }, (er, is) => {
          if (!er && is) {
            if (opt.all)
              found.push(p + ext);
            else
              return resolve(p + ext);
          }
          return resolve(subStep(p, i, ii + 1));
        });
      });
      return cb ? step(0).then((res) => cb(null, res), cb) : step(0);
    };
    var whichSync = (cmd, opt) => {
      opt = opt || {};
      const { pathEnv, pathExt, pathExtExe } = getPathInfo(cmd, opt);
      const found = [];
      for (let i = 0; i < pathEnv.length; i++) {
        const ppRaw = pathEnv[i];
        const pathPart = /^".*"$/.test(ppRaw) ? ppRaw.slice(1, -1) : ppRaw;
        const pCmd = path.join(pathPart, cmd);
        const p = !pathPart && /^\.[\\\/]/.test(cmd) ? cmd.slice(0, 2) + pCmd : pCmd;
        for (let j = 0; j < pathExt.length; j++) {
          const cur = p + pathExt[j];
          try {
            const is = isexe.sync(cur, { pathExt: pathExtExe });
            if (is) {
              if (opt.all)
                found.push(cur);
              else
                return cur;
            }
          } catch (ex) {
          }
        }
      }
      if (opt.all && found.length)
        return found;
      if (opt.nothrow)
        return null;
      throw getNotFoundError(cmd);
    };
    module2.exports = which;
    which.sync = whichSync;
  }
});

// node_modules/path-key/index.js
var require_path_key = __commonJS({
  "node_modules/path-key/index.js"(exports2, module2) {
    "use strict";
    var pathKey = (options2 = {}) => {
      const environment = options2.env || process.env;
      const platform = options2.platform || process.platform;
      if (platform !== "win32") {
        return "PATH";
      }
      return Object.keys(environment).reverse().find((key) => key.toUpperCase() === "PATH") || "Path";
    };
    module2.exports = pathKey;
    module2.exports.default = pathKey;
  }
});

// node_modules/cross-spawn/lib/util/resolveCommand.js
var require_resolveCommand = __commonJS({
  "node_modules/cross-spawn/lib/util/resolveCommand.js"(exports2, module2) {
    "use strict";
    var path = require("path");
    var which = require_which();
    var getPathKey = require_path_key();
    function resolveCommandAttempt(parsed, withoutPathExt) {
      const env = parsed.options.env || process.env;
      const cwd = process.cwd();
      const hasCustomCwd = parsed.options.cwd != null;
      const shouldSwitchCwd = hasCustomCwd && process.chdir !== void 0 && !process.chdir.disabled;
      if (shouldSwitchCwd) {
        try {
          process.chdir(parsed.options.cwd);
        } catch (err) {
        }
      }
      let resolved;
      try {
        resolved = which.sync(parsed.command, {
          path: env[getPathKey({ env })],
          pathExt: withoutPathExt ? path.delimiter : void 0
        });
      } catch (e) {
      } finally {
        if (shouldSwitchCwd) {
          process.chdir(cwd);
        }
      }
      if (resolved) {
        resolved = path.resolve(hasCustomCwd ? parsed.options.cwd : "", resolved);
      }
      return resolved;
    }
    function resolveCommand(parsed) {
      return resolveCommandAttempt(parsed) || resolveCommandAttempt(parsed, true);
    }
    module2.exports = resolveCommand;
  }
});

// node_modules/cross-spawn/lib/util/escape.js
var require_escape = __commonJS({
  "node_modules/cross-spawn/lib/util/escape.js"(exports2, module2) {
    "use strict";
    var metaCharsRegExp = /([()\][%!^"`<>&|;, *?])/g;
    function escapeCommand(arg) {
      arg = arg.replace(metaCharsRegExp, "^$1");
      return arg;
    }
    function escapeArgument(arg, doubleEscapeMetaChars) {
      arg = `${arg}`;
      arg = arg.replace(/(?=(\\+?)?)\1"/g, '$1$1\\"');
      arg = arg.replace(/(?=(\\+?)?)\1$/, "$1$1");
      arg = `"${arg}"`;
      arg = arg.replace(metaCharsRegExp, "^$1");
      if (doubleEscapeMetaChars) {
        arg = arg.replace(metaCharsRegExp, "^$1");
      }
      return arg;
    }
    module2.exports.command = escapeCommand;
    module2.exports.argument = escapeArgument;
  }
});

// node_modules/shebang-regex/index.js
var require_shebang_regex = __commonJS({
  "node_modules/shebang-regex/index.js"(exports2, module2) {
    "use strict";
    module2.exports = /^#!(.*)/;
  }
});

// node_modules/shebang-command/index.js
var require_shebang_command = __commonJS({
  "node_modules/shebang-command/index.js"(exports2, module2) {
    "use strict";
    var shebangRegex = require_shebang_regex();
    module2.exports = (string = "") => {
      const match = string.match(shebangRegex);
      if (!match) {
        return null;
      }
      const [path, argument] = match[0].replace(/#! ?/, "").split(" ");
      const binary = path.split("/").pop();
      if (binary === "env") {
        return argument;
      }
      return argument ? `${binary} ${argument}` : binary;
    };
  }
});

// node_modules/cross-spawn/lib/util/readShebang.js
var require_readShebang = __commonJS({
  "node_modules/cross-spawn/lib/util/readShebang.js"(exports2, module2) {
    "use strict";
    var fs2 = require("fs");
    var shebangCommand = require_shebang_command();
    function readShebang(command) {
      const size = 150;
      const buffer = Buffer.alloc(size);
      let fd;
      try {
        fd = fs2.openSync(command, "r");
        fs2.readSync(fd, buffer, 0, size, 0);
        fs2.closeSync(fd);
      } catch (e) {
      }
      return shebangCommand(buffer.toString());
    }
    module2.exports = readShebang;
  }
});

// node_modules/cross-spawn/lib/parse.js
var require_parse = __commonJS({
  "node_modules/cross-spawn/lib/parse.js"(exports2, module2) {
    "use strict";
    var path = require("path");
    var resolveCommand = require_resolveCommand();
    var escape2 = require_escape();
    var readShebang = require_readShebang();
    var isWin = process.platform === "win32";
    var isExecutableRegExp = /\.(?:com|exe)$/i;
    var isCmdShimRegExp = /node_modules[\\/].bin[\\/][^\\/]+\.cmd$/i;
    function detectShebang(parsed) {
      parsed.file = resolveCommand(parsed);
      const shebang = parsed.file && readShebang(parsed.file);
      if (shebang) {
        parsed.args.unshift(parsed.file);
        parsed.command = shebang;
        return resolveCommand(parsed);
      }
      return parsed.file;
    }
    function parseNonShell(parsed) {
      if (!isWin) {
        return parsed;
      }
      const commandFile = detectShebang(parsed);
      const needsShell = !isExecutableRegExp.test(commandFile);
      if (parsed.options.forceShell || needsShell) {
        const needsDoubleEscapeMetaChars = isCmdShimRegExp.test(commandFile);
        parsed.command = path.normalize(parsed.command);
        parsed.command = escape2.command(parsed.command);
        parsed.args = parsed.args.map((arg) => escape2.argument(arg, needsDoubleEscapeMetaChars));
        const shellCommand = [parsed.command].concat(parsed.args).join(" ");
        parsed.args = ["/d", "/s", "/c", `"${shellCommand}"`];
        parsed.command = process.env.comspec || "cmd.exe";
        parsed.options.windowsVerbatimArguments = true;
      }
      return parsed;
    }
    function parse(command, args, options2) {
      if (args && !Array.isArray(args)) {
        options2 = args;
        args = null;
      }
      args = args ? args.slice(0) : [];
      options2 = Object.assign({}, options2);
      const parsed = {
        command,
        args,
        options: options2,
        file: void 0,
        original: {
          command,
          args
        }
      };
      return options2.shell ? parsed : parseNonShell(parsed);
    }
    module2.exports = parse;
  }
});

// node_modules/cross-spawn/lib/enoent.js
var require_enoent = __commonJS({
  "node_modules/cross-spawn/lib/enoent.js"(exports2, module2) {
    "use strict";
    var isWin = process.platform === "win32";
    function notFoundError(original, syscall) {
      return Object.assign(new Error(`${syscall} ${original.command} ENOENT`), {
        code: "ENOENT",
        errno: "ENOENT",
        syscall: `${syscall} ${original.command}`,
        path: original.command,
        spawnargs: original.args
      });
    }
    function hookChildProcess(cp, parsed) {
      if (!isWin) {
        return;
      }
      const originalEmit = cp.emit;
      cp.emit = function(name, arg1) {
        if (name === "exit") {
          const err = verifyENOENT(arg1, parsed);
          if (err) {
            return originalEmit.call(cp, "error", err);
          }
        }
        return originalEmit.apply(cp, arguments);
      };
    }
    function verifyENOENT(status, parsed) {
      if (isWin && status === 1 && !parsed.file) {
        return notFoundError(parsed.original, "spawn");
      }
      return null;
    }
    function verifyENOENTSync(status, parsed) {
      if (isWin && status === 1 && !parsed.file) {
        return notFoundError(parsed.original, "spawnSync");
      }
      return null;
    }
    module2.exports = {
      hookChildProcess,
      verifyENOENT,
      verifyENOENTSync,
      notFoundError
    };
  }
});

// node_modules/cross-spawn/index.js
var require_cross_spawn = __commonJS({
  "node_modules/cross-spawn/index.js"(exports2, module2) {
    "use strict";
    var cp = require("child_process");
    var parse = require_parse();
    var enoent = require_enoent();
    function spawn(command, args, options2) {
      const parsed = parse(command, args, options2);
      const spawned = cp.spawn(parsed.command, parsed.args, parsed.options);
      enoent.hookChildProcess(spawned, parsed);
      return spawned;
    }
    function spawnSync(command, args, options2) {
      const parsed = parse(command, args, options2);
      const result = cp.spawnSync(parsed.command, parsed.args, parsed.options);
      result.error = result.error || enoent.verifyENOENTSync(result.status, parsed);
      return result;
    }
    module2.exports = spawn;
    module2.exports.spawn = spawn;
    module2.exports.sync = spawnSync;
    module2.exports._parse = parse;
    module2.exports._enoent = enoent;
  }
});

// node_modules/strip-final-newline/index.js
var require_strip_final_newline = __commonJS({
  "node_modules/strip-final-newline/index.js"(exports2, module2) {
    "use strict";
    module2.exports = (input) => {
      const LF = typeof input === "string" ? "\n" : "\n".charCodeAt();
      const CR = typeof input === "string" ? "\r" : "\r".charCodeAt();
      if (input[input.length - 1] === LF) {
        input = input.slice(0, input.length - 1);
      }
      if (input[input.length - 1] === CR) {
        input = input.slice(0, input.length - 1);
      }
      return input;
    };
  }
});

// node_modules/npm-run-path/index.js
var require_npm_run_path = __commonJS({
  "node_modules/npm-run-path/index.js"(exports2, module2) {
    "use strict";
    var path = require("path");
    var pathKey = require_path_key();
    var npmRunPath = (options2) => {
      options2 = {
        cwd: process.cwd(),
        path: process.env[pathKey()],
        execPath: process.execPath,
        ...options2
      };
      let previous;
      let cwdPath = path.resolve(options2.cwd);
      const result = [];
      while (previous !== cwdPath) {
        result.push(path.join(cwdPath, "node_modules/.bin"));
        previous = cwdPath;
        cwdPath = path.resolve(cwdPath, "..");
      }
      const execPathDir = path.resolve(options2.cwd, options2.execPath, "..");
      result.push(execPathDir);
      return result.concat(options2.path).join(path.delimiter);
    };
    module2.exports = npmRunPath;
    module2.exports.default = npmRunPath;
    module2.exports.env = (options2) => {
      options2 = {
        env: process.env,
        ...options2
      };
      const env = { ...options2.env };
      const path2 = pathKey({ env });
      options2.path = env[path2];
      env[path2] = module2.exports(options2);
      return env;
    };
  }
});

// node_modules/mimic-fn/index.js
var require_mimic_fn = __commonJS({
  "node_modules/mimic-fn/index.js"(exports2, module2) {
    "use strict";
    var mimicFn = (to, from) => {
      for (const prop of Reflect.ownKeys(from)) {
        Object.defineProperty(to, prop, Object.getOwnPropertyDescriptor(from, prop));
      }
      return to;
    };
    module2.exports = mimicFn;
    module2.exports.default = mimicFn;
  }
});

// node_modules/onetime/index.js
var require_onetime = __commonJS({
  "node_modules/onetime/index.js"(exports2, module2) {
    "use strict";
    var mimicFn = require_mimic_fn();
    var calledFunctions = /* @__PURE__ */ new WeakMap();
    var onetime = (function_, options2 = {}) => {
      if (typeof function_ !== "function") {
        throw new TypeError("Expected a function");
      }
      let returnValue;
      let callCount = 0;
      const functionName = function_.displayName || function_.name || "<anonymous>";
      const onetime2 = function(...arguments_) {
        calledFunctions.set(onetime2, ++callCount);
        if (callCount === 1) {
          returnValue = function_.apply(this, arguments_);
          function_ = null;
        } else if (options2.throw === true) {
          throw new Error(`Function \`${functionName}\` can only be called once`);
        }
        return returnValue;
      };
      mimicFn(onetime2, function_);
      calledFunctions.set(onetime2, callCount);
      return onetime2;
    };
    module2.exports = onetime;
    module2.exports.default = onetime;
    module2.exports.callCount = (function_) => {
      if (!calledFunctions.has(function_)) {
        throw new Error(`The given function \`${function_.name}\` is not wrapped by the \`onetime\` package`);
      }
      return calledFunctions.get(function_);
    };
  }
});

// node_modules/human-signals/build/src/core.js
var require_core = __commonJS({
  "node_modules/human-signals/build/src/core.js"(exports2) {
    "use strict";
    Object.defineProperty(exports2, "__esModule", { value: true });
    exports2.SIGNALS = void 0;
    var SIGNALS = [
      {
        name: "SIGHUP",
        number: 1,
        action: "terminate",
        description: "Terminal closed",
        standard: "posix"
      },
      {
        name: "SIGINT",
        number: 2,
        action: "terminate",
        description: "User interruption with CTRL-C",
        standard: "ansi"
      },
      {
        name: "SIGQUIT",
        number: 3,
        action: "core",
        description: "User interruption with CTRL-\\",
        standard: "posix"
      },
      {
        name: "SIGILL",
        number: 4,
        action: "core",
        description: "Invalid machine instruction",
        standard: "ansi"
      },
      {
        name: "SIGTRAP",
        number: 5,
        action: "core",
        description: "Debugger breakpoint",
        standard: "posix"
      },
      {
        name: "SIGABRT",
        number: 6,
        action: "core",
        description: "Aborted",
        standard: "ansi"
      },
      {
        name: "SIGIOT",
        number: 6,
        action: "core",
        description: "Aborted",
        standard: "bsd"
      },
      {
        name: "SIGBUS",
        number: 7,
        action: "core",
        description: "Bus error due to misaligned, non-existing address or paging error",
        standard: "bsd"
      },
      {
        name: "SIGEMT",
        number: 7,
        action: "terminate",
        description: "Command should be emulated but is not implemented",
        standard: "other"
      },
      {
        name: "SIGFPE",
        number: 8,
        action: "core",
        description: "Floating point arithmetic error",
        standard: "ansi"
      },
      {
        name: "SIGKILL",
        number: 9,
        action: "terminate",
        description: "Forced termination",
        standard: "posix",
        forced: true
      },
      {
        name: "SIGUSR1",
        number: 10,
        action: "terminate",
        description: "Application-specific signal",
        standard: "posix"
      },
      {
        name: "SIGSEGV",
        number: 11,
        action: "core",
        description: "Segmentation fault",
        standard: "ansi"
      },
      {
        name: "SIGUSR2",
        number: 12,
        action: "terminate",
        description: "Application-specific signal",
        standard: "posix"
      },
      {
        name: "SIGPIPE",
        number: 13,
        action: "terminate",
        description: "Broken pipe or socket",
        standard: "posix"
      },
      {
        name: "SIGALRM",
        number: 14,
        action: "terminate",
        description: "Timeout or timer",
        standard: "posix"
      },
      {
        name: "SIGTERM",
        number: 15,
        action: "terminate",
        description: "Termination",
        standard: "ansi"
      },
      {
        name: "SIGSTKFLT",
        number: 16,
        action: "terminate",
        description: "Stack is empty or overflowed",
        standard: "other"
      },
      {
        name: "SIGCHLD",
        number: 17,
        action: "ignore",
        description: "Child process terminated, paused or unpaused",
        standard: "posix"
      },
      {
        name: "SIGCLD",
        number: 17,
        action: "ignore",
        description: "Child process terminated, paused or unpaused",
        standard: "other"
      },
      {
        name: "SIGCONT",
        number: 18,
        action: "unpause",
        description: "Unpaused",
        standard: "posix",
        forced: true
      },
      {
        name: "SIGSTOP",
        number: 19,
        action: "pause",
        description: "Paused",
        standard: "posix",
        forced: true
      },
      {
        name: "SIGTSTP",
        number: 20,
        action: "pause",
        description: 'Paused using CTRL-Z or "suspend"',
        standard: "posix"
      },
      {
        name: "SIGTTIN",
        number: 21,
        action: "pause",
        description: "Background process cannot read terminal input",
        standard: "posix"
      },
      {
        name: "SIGBREAK",
        number: 21,
        action: "terminate",
        description: "User interruption with CTRL-BREAK",
        standard: "other"
      },
      {
        name: "SIGTTOU",
        number: 22,
        action: "pause",
        description: "Background process cannot write to terminal output",
        standard: "posix"
      },
      {
        name: "SIGURG",
        number: 23,
        action: "ignore",
        description: "Socket received out-of-band data",
        standard: "bsd"
      },
      {
        name: "SIGXCPU",
        number: 24,
        action: "core",
        description: "Process timed out",
        standard: "bsd"
      },
      {
        name: "SIGXFSZ",
        number: 25,
        action: "core",
        description: "File too big",
        standard: "bsd"
      },
      {
        name: "SIGVTALRM",
        number: 26,
        action: "terminate",
        description: "Timeout or timer",
        standard: "bsd"
      },
      {
        name: "SIGPROF",
        number: 27,
        action: "terminate",
        description: "Timeout or timer",
        standard: "bsd"
      },
      {
        name: "SIGWINCH",
        number: 28,
        action: "ignore",
        description: "Terminal window size changed",
        standard: "bsd"
      },
      {
        name: "SIGIO",
        number: 29,
        action: "terminate",
        description: "I/O is available",
        standard: "other"
      },
      {
        name: "SIGPOLL",
        number: 29,
        action: "terminate",
        description: "Watched event",
        standard: "other"
      },
      {
        name: "SIGINFO",
        number: 29,
        action: "ignore",
        description: "Request for process information",
        standard: "other"
      },
      {
        name: "SIGPWR",
        number: 30,
        action: "terminate",
        description: "Device running out of power",
        standard: "systemv"
      },
      {
        name: "SIGSYS",
        number: 31,
        action: "core",
        description: "Invalid system call",
        standard: "other"
      },
      {
        name: "SIGUNUSED",
        number: 31,
        action: "terminate",
        description: "Invalid system call",
        standard: "other"
      }
    ];
    exports2.SIGNALS = SIGNALS;
  }
});

// node_modules/human-signals/build/src/realtime.js
var require_realtime = __commonJS({
  "node_modules/human-signals/build/src/realtime.js"(exports2) {
    "use strict";
    Object.defineProperty(exports2, "__esModule", { value: true });
    exports2.SIGRTMAX = exports2.getRealtimeSignals = void 0;
    var getRealtimeSignals = function() {
      const length = SIGRTMAX - SIGRTMIN + 1;
      return Array.from({ length }, getRealtimeSignal);
    };
    exports2.getRealtimeSignals = getRealtimeSignals;
    var getRealtimeSignal = function(value, index) {
      return {
        name: `SIGRT${index + 1}`,
        number: SIGRTMIN + index,
        action: "terminate",
        description: "Application-specific signal (realtime)",
        standard: "posix"
      };
    };
    var SIGRTMIN = 34;
    var SIGRTMAX = 64;
    exports2.SIGRTMAX = SIGRTMAX;
  }
});

// node_modules/human-signals/build/src/signals.js
var require_signals = __commonJS({
  "node_modules/human-signals/build/src/signals.js"(exports2) {
    "use strict";
    Object.defineProperty(exports2, "__esModule", { value: true });
    exports2.getSignals = void 0;
    var _os = require("os");
    var _core = require_core();
    var _realtime = require_realtime();
    var getSignals = function() {
      const realtimeSignals = (0, _realtime.getRealtimeSignals)();
      const signals = [..._core.SIGNALS, ...realtimeSignals].map(normalizeSignal);
      return signals;
    };
    exports2.getSignals = getSignals;
    var normalizeSignal = function({
      name,
      number: defaultNumber,
      description,
      action,
      forced = false,
      standard
    }) {
      const {
        signals: { [name]: constantSignal }
      } = _os.constants;
      const supported = constantSignal !== void 0;
      const number = supported ? constantSignal : defaultNumber;
      return { name, number, description, supported, action, forced, standard };
    };
  }
});

// node_modules/human-signals/build/src/main.js
var require_main = __commonJS({
  "node_modules/human-signals/build/src/main.js"(exports2) {
    "use strict";
    Object.defineProperty(exports2, "__esModule", { value: true });
    exports2.signalsByNumber = exports2.signalsByName = void 0;
    var _os = require("os");
    var _signals = require_signals();
    var _realtime = require_realtime();
    var getSignalsByName = function() {
      const signals = (0, _signals.getSignals)();
      return signals.reduce(getSignalByName, {});
    };
    var getSignalByName = function(signalByNameMemo, { name, number, description, supported, action, forced, standard }) {
      return {
        ...signalByNameMemo,
        [name]: { name, number, description, supported, action, forced, standard }
      };
    };
    var signalsByName = getSignalsByName();
    exports2.signalsByName = signalsByName;
    var getSignalsByNumber = function() {
      const signals = (0, _signals.getSignals)();
      const length = _realtime.SIGRTMAX + 1;
      const signalsA = Array.from({ length }, (value, number) => getSignalByNumber(number, signals));
      return Object.assign({}, ...signalsA);
    };
    var getSignalByNumber = function(number, signals) {
      const signal = findSignalByNumber(number, signals);
      if (signal === void 0) {
        return {};
      }
      const { name, description, supported, action, forced, standard } = signal;
      return {
        [number]: {
          name,
          number,
          description,
          supported,
          action,
          forced,
          standard
        }
      };
    };
    var findSignalByNumber = function(number, signals) {
      const signal = signals.find(({ name }) => _os.constants.signals[name] === number);
      if (signal !== void 0) {
        return signal;
      }
      return signals.find((signalA) => signalA.number === number);
    };
    var signalsByNumber = getSignalsByNumber();
    exports2.signalsByNumber = signalsByNumber;
  }
});

// node_modules/execa/lib/error.js
var require_error = __commonJS({
  "node_modules/execa/lib/error.js"(exports2, module2) {
    "use strict";
    var { signalsByName } = require_main();
    var getErrorPrefix = ({ timedOut, timeout, errorCode, signal, signalDescription, exitCode, isCanceled }) => {
      if (timedOut) {
        return `timed out after ${timeout} milliseconds`;
      }
      if (isCanceled) {
        return "was canceled";
      }
      if (errorCode !== void 0) {
        return `failed with ${errorCode}`;
      }
      if (signal !== void 0) {
        return `was killed with ${signal} (${signalDescription})`;
      }
      if (exitCode !== void 0) {
        return `failed with exit code ${exitCode}`;
      }
      return "failed";
    };
    var makeError = ({
      stdout,
      stderr,
      all,
      error,
      signal,
      exitCode,
      command,
      escapedCommand,
      timedOut,
      isCanceled,
      killed,
      parsed: { options: { timeout } }
    }) => {
      exitCode = exitCode === null ? void 0 : exitCode;
      signal = signal === null ? void 0 : signal;
      const signalDescription = signal === void 0 ? void 0 : signalsByName[signal].description;
      const errorCode = error && error.code;
      const prefix = getErrorPrefix({ timedOut, timeout, errorCode, signal, signalDescription, exitCode, isCanceled });
      const execaMessage = `Command ${prefix}: ${command}`;
      const isError = Object.prototype.toString.call(error) === "[object Error]";
      const shortMessage = isError ? `${execaMessage}
${error.message}` : execaMessage;
      const message = [shortMessage, stderr, stdout].filter(Boolean).join("\n");
      if (isError) {
        error.originalMessage = error.message;
        error.message = message;
      } else {
        error = new Error(message);
      }
      error.shortMessage = shortMessage;
      error.command = command;
      error.escapedCommand = escapedCommand;
      error.exitCode = exitCode;
      error.signal = signal;
      error.signalDescription = signalDescription;
      error.stdout = stdout;
      error.stderr = stderr;
      if (all !== void 0) {
        error.all = all;
      }
      if ("bufferedData" in error) {
        delete error.bufferedData;
      }
      error.failed = true;
      error.timedOut = Boolean(timedOut);
      error.isCanceled = isCanceled;
      error.killed = killed && !timedOut;
      return error;
    };
    module2.exports = makeError;
  }
});

// node_modules/execa/lib/stdio.js
var require_stdio = __commonJS({
  "node_modules/execa/lib/stdio.js"(exports2, module2) {
    "use strict";
    var aliases = ["stdin", "stdout", "stderr"];
    var hasAlias = (options2) => aliases.some((alias) => options2[alias] !== void 0);
    var normalizeStdio = (options2) => {
      if (!options2) {
        return;
      }
      const { stdio } = options2;
      if (stdio === void 0) {
        return aliases.map((alias) => options2[alias]);
      }
      if (hasAlias(options2)) {
        throw new Error(`It's not possible to provide \`stdio\` in combination with one of ${aliases.map((alias) => `\`${alias}\``).join(", ")}`);
      }
      if (typeof stdio === "string") {
        return stdio;
      }
      if (!Array.isArray(stdio)) {
        throw new TypeError(`Expected \`stdio\` to be of type \`string\` or \`Array\`, got \`${typeof stdio}\``);
      }
      const length = Math.max(stdio.length, aliases.length);
      return Array.from({ length }, (value, index) => stdio[index]);
    };
    module2.exports = normalizeStdio;
    module2.exports.node = (options2) => {
      const stdio = normalizeStdio(options2);
      if (stdio === "ipc") {
        return "ipc";
      }
      if (stdio === void 0 || typeof stdio === "string") {
        return [stdio, stdio, stdio, "ipc"];
      }
      if (stdio.includes("ipc")) {
        return stdio;
      }
      return [...stdio, "ipc"];
    };
  }
});

// node_modules/signal-exit/signals.js
var require_signals2 = __commonJS({
  "node_modules/signal-exit/signals.js"(exports2, module2) {
    module2.exports = [
      "SIGABRT",
      "SIGALRM",
      "SIGHUP",
      "SIGINT",
      "SIGTERM"
    ];
    if (process.platform !== "win32") {
      module2.exports.push(
        "SIGVTALRM",
        "SIGXCPU",
        "SIGXFSZ",
        "SIGUSR2",
        "SIGTRAP",
        "SIGSYS",
        "SIGQUIT",
        "SIGIOT"
        // should detect profiler and enable/disable accordingly.
        // see #21
        // 'SIGPROF'
      );
    }
    if (process.platform === "linux") {
      module2.exports.push(
        "SIGIO",
        "SIGPOLL",
        "SIGPWR",
        "SIGSTKFLT",
        "SIGUNUSED"
      );
    }
  }
});

// node_modules/signal-exit/index.js
var require_signal_exit = __commonJS({
  "node_modules/signal-exit/index.js"(exports2, module2) {
    var assert = require("assert");
    var signals = require_signals2();
    var isWin = /^win/i.test(process.platform);
    var EE = require("events");
    if (typeof EE !== "function") {
      EE = EE.EventEmitter;
    }
    var emitter;
    if (process.__signal_exit_emitter__) {
      emitter = process.__signal_exit_emitter__;
    } else {
      emitter = process.__signal_exit_emitter__ = new EE();
      emitter.count = 0;
      emitter.emitted = {};
    }
    if (!emitter.infinite) {
      emitter.setMaxListeners(Infinity);
      emitter.infinite = true;
    }
    module2.exports = function(cb, opts) {
      assert.equal(typeof cb, "function", "a callback must be provided for exit handler");
      if (loaded === false) {
        load();
      }
      var ev = "exit";
      if (opts && opts.alwaysLast) {
        ev = "afterexit";
      }
      var remove = function() {
        emitter.removeListener(ev, cb);
        if (emitter.listeners("exit").length === 0 && emitter.listeners("afterexit").length === 0) {
          unload();
        }
      };
      emitter.on(ev, cb);
      return remove;
    };
    module2.exports.unload = unload;
    function unload() {
      if (!loaded) {
        return;
      }
      loaded = false;
      signals.forEach(function(sig) {
        try {
          process.removeListener(sig, sigListeners[sig]);
        } catch (er) {
        }
      });
      process.emit = originalProcessEmit;
      process.reallyExit = originalProcessReallyExit;
      emitter.count -= 1;
    }
    function emit(event, code, signal) {
      if (emitter.emitted[event]) {
        return;
      }
      emitter.emitted[event] = true;
      emitter.emit(event, code, signal);
    }
    var sigListeners = {};
    signals.forEach(function(sig) {
      sigListeners[sig] = function listener() {
        var listeners = process.listeners(sig);
        if (listeners.length === emitter.count) {
          unload();
          emit("exit", null, sig);
          emit("afterexit", null, sig);
          if (isWin && sig === "SIGHUP") {
            sig = "SIGINT";
          }
          process.kill(process.pid, sig);
        }
      };
    });
    module2.exports.signals = function() {
      return signals;
    };
    module2.exports.load = load;
    var loaded = false;
    function load() {
      if (loaded) {
        return;
      }
      loaded = true;
      emitter.count += 1;
      signals = signals.filter(function(sig) {
        try {
          process.on(sig, sigListeners[sig]);
          return true;
        } catch (er) {
          return false;
        }
      });
      process.emit = processEmit;
      process.reallyExit = processReallyExit;
    }
    var originalProcessReallyExit = process.reallyExit;
    function processReallyExit(code) {
      process.exitCode = code || 0;
      emit("exit", process.exitCode, null);
      emit("afterexit", process.exitCode, null);
      originalProcessReallyExit.call(process, process.exitCode);
    }
    var originalProcessEmit = process.emit;
    function processEmit(ev, arg) {
      if (ev === "exit") {
        if (arg !== void 0) {
          process.exitCode = arg;
        }
        var ret = originalProcessEmit.apply(this, arguments);
        emit("exit", process.exitCode, null);
        emit("afterexit", process.exitCode, null);
        return ret;
      } else {
        return originalProcessEmit.apply(this, arguments);
      }
    }
  }
});

// node_modules/execa/lib/kill.js
var require_kill = __commonJS({
  "node_modules/execa/lib/kill.js"(exports2, module2) {
    "use strict";
    var os = require("os");
    var onExit = require_signal_exit();
    var DEFAULT_FORCE_KILL_TIMEOUT = 1e3 * 5;
    var spawnedKill = (kill, signal = "SIGTERM", options2 = {}) => {
      const killResult = kill(signal);
      setKillTimeout(kill, signal, options2, killResult);
      return killResult;
    };
    var setKillTimeout = (kill, signal, options2, killResult) => {
      if (!shouldForceKill(signal, options2, killResult)) {
        return;
      }
      const timeout = getForceKillAfterTimeout(options2);
      const t = setTimeout(() => {
        kill("SIGKILL");
      }, timeout);
      if (t.unref) {
        t.unref();
      }
    };
    var shouldForceKill = (signal, { forceKillAfterTimeout }, killResult) => {
      return isSigterm(signal) && forceKillAfterTimeout !== false && killResult;
    };
    var isSigterm = (signal) => {
      return signal === os.constants.signals.SIGTERM || typeof signal === "string" && signal.toUpperCase() === "SIGTERM";
    };
    var getForceKillAfterTimeout = ({ forceKillAfterTimeout = true }) => {
      if (forceKillAfterTimeout === true) {
        return DEFAULT_FORCE_KILL_TIMEOUT;
      }
      if (!Number.isFinite(forceKillAfterTimeout) || forceKillAfterTimeout < 0) {
        throw new TypeError(`Expected the \`forceKillAfterTimeout\` option to be a non-negative integer, got \`${forceKillAfterTimeout}\` (${typeof forceKillAfterTimeout})`);
      }
      return forceKillAfterTimeout;
    };
    var spawnedCancel = (spawned, context) => {
      const killResult = spawned.kill();
      if (killResult) {
        context.isCanceled = true;
      }
    };
    var timeoutKill = (spawned, signal, reject) => {
      spawned.kill(signal);
      reject(Object.assign(new Error("Timed out"), { timedOut: true, signal }));
    };
    var setupTimeout = (spawned, { timeout, killSignal = "SIGTERM" }, spawnedPromise) => {
      if (timeout === 0 || timeout === void 0) {
        return spawnedPromise;
      }
      let timeoutId;
      const timeoutPromise = new Promise((resolve, reject) => {
        timeoutId = setTimeout(() => {
          timeoutKill(spawned, killSignal, reject);
        }, timeout);
      });
      const safeSpawnedPromise = spawnedPromise.finally(() => {
        clearTimeout(timeoutId);
      });
      return Promise.race([timeoutPromise, safeSpawnedPromise]);
    };
    var validateTimeout = ({ timeout }) => {
      if (timeout !== void 0 && (!Number.isFinite(timeout) || timeout < 0)) {
        throw new TypeError(`Expected the \`timeout\` option to be a non-negative integer, got \`${timeout}\` (${typeof timeout})`);
      }
    };
    var setExitHandler = async (spawned, { cleanup, detached }, timedPromise) => {
      if (!cleanup || detached) {
        return timedPromise;
      }
      const removeExitHandler = onExit(() => {
        spawned.kill();
      });
      return timedPromise.finally(() => {
        removeExitHandler();
      });
    };
    module2.exports = {
      spawnedKill,
      spawnedCancel,
      setupTimeout,
      validateTimeout,
      setExitHandler
    };
  }
});

// node_modules/is-stream/index.js
var require_is_stream = __commonJS({
  "node_modules/is-stream/index.js"(exports2, module2) {
    "use strict";
    var isStream = (stream) => stream !== null && typeof stream === "object" && typeof stream.pipe === "function";
    isStream.writable = (stream) => isStream(stream) && stream.writable !== false && typeof stream._write === "function" && typeof stream._writableState === "object";
    isStream.readable = (stream) => isStream(stream) && stream.readable !== false && typeof stream._read === "function" && typeof stream._readableState === "object";
    isStream.duplex = (stream) => isStream.writable(stream) && isStream.readable(stream);
    isStream.transform = (stream) => isStream.duplex(stream) && typeof stream._transform === "function" && typeof stream._transformState === "object";
    module2.exports = isStream;
  }
});

// node_modules/get-stream/buffer-stream.js
var require_buffer_stream = __commonJS({
  "node_modules/get-stream/buffer-stream.js"(exports2, module2) {
    "use strict";
    var { PassThrough: PassThroughStream } = require("stream");
    module2.exports = (options2) => {
      options2 = { ...options2 };
      const { array } = options2;
      let { encoding } = options2;
      const isBuffer = encoding === "buffer";
      let objectMode = false;
      if (array) {
        objectMode = !(encoding || isBuffer);
      } else {
        encoding = encoding || "utf8";
      }
      if (isBuffer) {
        encoding = null;
      }
      const stream = new PassThroughStream({ objectMode });
      if (encoding) {
        stream.setEncoding(encoding);
      }
      let length = 0;
      const chunks = [];
      stream.on("data", (chunk) => {
        chunks.push(chunk);
        if (objectMode) {
          length = chunks.length;
        } else {
          length += chunk.length;
        }
      });
      stream.getBufferedValue = () => {
        if (array) {
          return chunks;
        }
        return isBuffer ? Buffer.concat(chunks, length) : chunks.join("");
      };
      stream.getBufferedLength = () => length;
      return stream;
    };
  }
});

// node_modules/get-stream/index.js
var require_get_stream = __commonJS({
  "node_modules/get-stream/index.js"(exports2, module2) {
    "use strict";
    var { constants: BufferConstants } = require("buffer");
    var stream = require("stream");
    var { promisify } = require("util");
    var bufferStream = require_buffer_stream();
    var streamPipelinePromisified = promisify(stream.pipeline);
    var MaxBufferError = class extends Error {
      constructor() {
        super("maxBuffer exceeded");
        this.name = "MaxBufferError";
      }
    };
    async function getStream(inputStream, options2) {
      if (!inputStream) {
        throw new Error("Expected a stream");
      }
      options2 = {
        maxBuffer: Infinity,
        ...options2
      };
      const { maxBuffer } = options2;
      const stream2 = bufferStream(options2);
      await new Promise((resolve, reject) => {
        const rejectPromise = (error) => {
          if (error && stream2.getBufferedLength() <= BufferConstants.MAX_LENGTH) {
            error.bufferedData = stream2.getBufferedValue();
          }
          reject(error);
        };
        (async () => {
          try {
            await streamPipelinePromisified(inputStream, stream2);
            resolve();
          } catch (error) {
            rejectPromise(error);
          }
        })();
        stream2.on("data", () => {
          if (stream2.getBufferedLength() > maxBuffer) {
            rejectPromise(new MaxBufferError());
          }
        });
      });
      return stream2.getBufferedValue();
    }
    module2.exports = getStream;
    module2.exports.buffer = (stream2, options2) => getStream(stream2, { ...options2, encoding: "buffer" });
    module2.exports.array = (stream2, options2) => getStream(stream2, { ...options2, array: true });
    module2.exports.MaxBufferError = MaxBufferError;
  }
});

// node_modules/merge-stream/index.js
var require_merge_stream = __commonJS({
  "node_modules/merge-stream/index.js"(exports2, module2) {
    "use strict";
    var { PassThrough } = require("stream");
    module2.exports = function() {
      var sources = [];
      var output = new PassThrough({ objectMode: true });
      output.setMaxListeners(0);
      output.add = add;
      output.isEmpty = isEmpty;
      output.on("unpipe", remove);
      Array.prototype.slice.call(arguments).forEach(add);
      return output;
      function add(source) {
        if (Array.isArray(source)) {
          source.forEach(add);
          return this;
        }
        sources.push(source);
        source.once("end", remove.bind(null, source));
        source.once("error", output.emit.bind(output, "error"));
        source.pipe(output, { end: false });
        return this;
      }
      function isEmpty() {
        return sources.length == 0;
      }
      function remove(source) {
        sources = sources.filter(function(it) {
          return it !== source;
        });
        if (!sources.length && output.readable) {
          output.end();
        }
      }
    };
  }
});

// node_modules/execa/lib/stream.js
var require_stream = __commonJS({
  "node_modules/execa/lib/stream.js"(exports2, module2) {
    "use strict";
    var isStream = require_is_stream();
    var getStream = require_get_stream();
    var mergeStream = require_merge_stream();
    var handleInput = (spawned, input) => {
      if (input === void 0 || spawned.stdin === void 0) {
        return;
      }
      if (isStream(input)) {
        input.pipe(spawned.stdin);
      } else {
        spawned.stdin.end(input);
      }
    };
    var makeAllStream = (spawned, { all }) => {
      if (!all || !spawned.stdout && !spawned.stderr) {
        return;
      }
      const mixed = mergeStream();
      if (spawned.stdout) {
        mixed.add(spawned.stdout);
      }
      if (spawned.stderr) {
        mixed.add(spawned.stderr);
      }
      return mixed;
    };
    var getBufferedData = async (stream, streamPromise) => {
      if (!stream) {
        return;
      }
      stream.destroy();
      try {
        return await streamPromise;
      } catch (error) {
        return error.bufferedData;
      }
    };
    var getStreamPromise = (stream, { encoding, buffer, maxBuffer }) => {
      if (!stream || !buffer) {
        return;
      }
      if (encoding) {
        return getStream(stream, { encoding, maxBuffer });
      }
      return getStream.buffer(stream, { maxBuffer });
    };
    var getSpawnedResult = async ({ stdout, stderr, all }, { encoding, buffer, maxBuffer }, processDone) => {
      const stdoutPromise = getStreamPromise(stdout, { encoding, buffer, maxBuffer });
      const stderrPromise = getStreamPromise(stderr, { encoding, buffer, maxBuffer });
      const allPromise = getStreamPromise(all, { encoding, buffer, maxBuffer: maxBuffer * 2 });
      try {
        return await Promise.all([processDone, stdoutPromise, stderrPromise, allPromise]);
      } catch (error) {
        return Promise.all([
          { error, signal: error.signal, timedOut: error.timedOut },
          getBufferedData(stdout, stdoutPromise),
          getBufferedData(stderr, stderrPromise),
          getBufferedData(all, allPromise)
        ]);
      }
    };
    var validateInputSync = ({ input }) => {
      if (isStream(input)) {
        throw new TypeError("The `input` option cannot be a stream in sync mode");
      }
    };
    module2.exports = {
      handleInput,
      makeAllStream,
      getSpawnedResult,
      validateInputSync
    };
  }
});

// node_modules/execa/lib/promise.js
var require_promise = __commonJS({
  "node_modules/execa/lib/promise.js"(exports2, module2) {
    "use strict";
    var nativePromisePrototype = (async () => {
    })().constructor.prototype;
    var descriptors = ["then", "catch", "finally"].map((property) => [
      property,
      Reflect.getOwnPropertyDescriptor(nativePromisePrototype, property)
    ]);
    var mergePromise = (spawned, promise) => {
      for (const [property, descriptor] of descriptors) {
        const value = typeof promise === "function" ? (...args) => Reflect.apply(descriptor.value, promise(), args) : descriptor.value.bind(promise);
        Reflect.defineProperty(spawned, property, { ...descriptor, value });
      }
      return spawned;
    };
    var getSpawnedPromise = (spawned) => {
      return new Promise((resolve, reject) => {
        spawned.on("exit", (exitCode, signal) => {
          resolve({ exitCode, signal });
        });
        spawned.on("error", (error) => {
          reject(error);
        });
        if (spawned.stdin) {
          spawned.stdin.on("error", (error) => {
            reject(error);
          });
        }
      });
    };
    module2.exports = {
      mergePromise,
      getSpawnedPromise
    };
  }
});

// node_modules/execa/lib/command.js
var require_command = __commonJS({
  "node_modules/execa/lib/command.js"(exports2, module2) {
    "use strict";
    var normalizeArgs = (file, args = []) => {
      if (!Array.isArray(args)) {
        return [file];
      }
      return [file, ...args];
    };
    var NO_ESCAPE_REGEXP = /^[\w.-]+$/;
    var DOUBLE_QUOTES_REGEXP = /"/g;
    var escapeArg = (arg) => {
      if (typeof arg !== "string" || NO_ESCAPE_REGEXP.test(arg)) {
        return arg;
      }
      return `"${arg.replace(DOUBLE_QUOTES_REGEXP, '\\"')}"`;
    };
    var joinCommand = (file, args) => {
      return normalizeArgs(file, args).join(" ");
    };
    var getEscapedCommand = (file, args) => {
      return normalizeArgs(file, args).map((arg) => escapeArg(arg)).join(" ");
    };
    var SPACES_REGEXP = / +/g;
    var parseCommand = (command) => {
      const tokens = [];
      for (const token of command.trim().split(SPACES_REGEXP)) {
        const previousToken = tokens[tokens.length - 1];
        if (previousToken && previousToken.endsWith("\\")) {
          tokens[tokens.length - 1] = `${previousToken.slice(0, -1)} ${token}`;
        } else {
          tokens.push(token);
        }
      }
      return tokens;
    };
    module2.exports = {
      joinCommand,
      getEscapedCommand,
      parseCommand
    };
  }
});

// node_modules/execa/index.js
var require_execa = __commonJS({
  "node_modules/execa/index.js"(exports2, module2) {
    "use strict";
    var path = require("path");
    var childProcess = require("child_process");
    var crossSpawn = require_cross_spawn();
    var stripFinalNewline = require_strip_final_newline();
    var npmRunPath = require_npm_run_path();
    var onetime = require_onetime();
    var makeError = require_error();
    var normalizeStdio = require_stdio();
    var { spawnedKill, spawnedCancel, setupTimeout, validateTimeout, setExitHandler } = require_kill();
    var { handleInput, getSpawnedResult, makeAllStream, validateInputSync } = require_stream();
    var { mergePromise, getSpawnedPromise } = require_promise();
    var { joinCommand, parseCommand, getEscapedCommand } = require_command();
    var DEFAULT_MAX_BUFFER = 1e3 * 1e3 * 100;
    var getEnv = ({ env: envOption, extendEnv, preferLocal, localDir, execPath }) => {
      const env = extendEnv ? { ...process.env, ...envOption } : envOption;
      if (preferLocal) {
        return npmRunPath.env({ env, cwd: localDir, execPath });
      }
      return env;
    };
    var handleArguments = (file, args, options2 = {}) => {
      const parsed = crossSpawn._parse(file, args, options2);
      file = parsed.command;
      args = parsed.args;
      options2 = parsed.options;
      options2 = {
        maxBuffer: DEFAULT_MAX_BUFFER,
        buffer: true,
        stripFinalNewline: true,
        extendEnv: true,
        preferLocal: false,
        localDir: options2.cwd || process.cwd(),
        execPath: process.execPath,
        encoding: "utf8",
        reject: true,
        cleanup: true,
        all: false,
        windowsHide: true,
        ...options2
      };
      options2.env = getEnv(options2);
      options2.stdio = normalizeStdio(options2);
      if (process.platform === "win32" && path.basename(file, ".exe") === "cmd") {
        args.unshift("/q");
      }
      return { file, args, options: options2, parsed };
    };
    var handleOutput = (options2, value, error) => {
      if (typeof value !== "string" && !Buffer.isBuffer(value)) {
        return error === void 0 ? void 0 : "";
      }
      if (options2.stripFinalNewline) {
        return stripFinalNewline(value);
      }
      return value;
    };
    var execa2 = (file, args, options2) => {
      const parsed = handleArguments(file, args, options2);
      const command = joinCommand(file, args);
      const escapedCommand = getEscapedCommand(file, args);
      validateTimeout(parsed.options);
      let spawned;
      try {
        spawned = childProcess.spawn(parsed.file, parsed.args, parsed.options);
      } catch (error) {
        const dummySpawned = new childProcess.ChildProcess();
        const errorPromise = Promise.reject(makeError({
          error,
          stdout: "",
          stderr: "",
          all: "",
          command,
          escapedCommand,
          parsed,
          timedOut: false,
          isCanceled: false,
          killed: false
        }));
        return mergePromise(dummySpawned, errorPromise);
      }
      const spawnedPromise = getSpawnedPromise(spawned);
      const timedPromise = setupTimeout(spawned, parsed.options, spawnedPromise);
      const processDone = setExitHandler(spawned, parsed.options, timedPromise);
      const context = { isCanceled: false };
      spawned.kill = spawnedKill.bind(null, spawned.kill.bind(spawned));
      spawned.cancel = spawnedCancel.bind(null, spawned, context);
      const handlePromise = async () => {
        const [{ error, exitCode, signal, timedOut }, stdoutResult, stderrResult, allResult] = await getSpawnedResult(spawned, parsed.options, processDone);
        const stdout = handleOutput(parsed.options, stdoutResult);
        const stderr = handleOutput(parsed.options, stderrResult);
        const all = handleOutput(parsed.options, allResult);
        if (error || exitCode !== 0 || signal !== null) {
          const returnedError = makeError({
            error,
            exitCode,
            signal,
            stdout,
            stderr,
            all,
            command,
            escapedCommand,
            parsed,
            timedOut,
            isCanceled: context.isCanceled,
            killed: spawned.killed
          });
          if (!parsed.options.reject) {
            return returnedError;
          }
          throw returnedError;
        }
        return {
          command,
          escapedCommand,
          exitCode: 0,
          stdout,
          stderr,
          all,
          failed: false,
          timedOut: false,
          isCanceled: false,
          killed: false
        };
      };
      const handlePromiseOnce = onetime(handlePromise);
      handleInput(spawned, parsed.options.input);
      spawned.all = makeAllStream(spawned, parsed.options);
      return mergePromise(spawned, handlePromiseOnce);
    };
    module2.exports = execa2;
    module2.exports.sync = (file, args, options2) => {
      const parsed = handleArguments(file, args, options2);
      const command = joinCommand(file, args);
      const escapedCommand = getEscapedCommand(file, args);
      validateInputSync(parsed.options);
      let result;
      try {
        result = childProcess.spawnSync(parsed.file, parsed.args, parsed.options);
      } catch (error) {
        throw makeError({
          error,
          stdout: "",
          stderr: "",
          all: "",
          command,
          escapedCommand,
          parsed,
          timedOut: false,
          isCanceled: false,
          killed: false
        });
      }
      const stdout = handleOutput(parsed.options, result.stdout, result.error);
      const stderr = handleOutput(parsed.options, result.stderr, result.error);
      if (result.error || result.status !== 0 || result.signal !== null) {
        const error = makeError({
          stdout,
          stderr,
          error: result.error,
          signal: result.signal,
          exitCode: result.status,
          command,
          escapedCommand,
          parsed,
          timedOut: result.error && result.error.code === "ETIMEDOUT",
          isCanceled: false,
          killed: result.signal !== null
        });
        if (!parsed.options.reject) {
          return error;
        }
        throw error;
      }
      return {
        command,
        escapedCommand,
        exitCode: 0,
        stdout,
        stderr,
        failed: false,
        timedOut: false,
        isCanceled: false,
        killed: false
      };
    };
    module2.exports.command = (command, options2) => {
      const [file, ...args] = parseCommand(command);
      return execa2(file, args, options2);
    };
    module2.exports.commandSync = (command, options2) => {
      const [file, ...args] = parseCommand(command);
      return execa2.sync(file, args, options2);
    };
    module2.exports.node = (scriptPath, args, options2 = {}) => {
      if (args && !Array.isArray(args) && typeof args === "object") {
        options2 = args;
        args = [];
      }
      const stdio = normalizeStdio.node(options2);
      const defaultExecArgv = process.execArgv.filter((arg) => !arg.startsWith("--inspect"));
      const {
        nodePath = process.execPath,
        nodeOptions = defaultExecArgv
      } = options2;
      return execa2(
        nodePath,
        [
          ...nodeOptions,
          scriptPath,
          ...Array.isArray(args) ? args : []
        ],
        {
          ...options2,
          stdin: void 0,
          stdout: void 0,
          stderr: void 0,
          stdio,
          shell: false
        }
      );
    };
  }
});

// src/build/documentReadme.ts
var import_execa = __toESM(require_execa());
var import_fs = require("fs");

// node_modules/marked/lib/marked.esm.js
function _getDefaults() {
  return {
    async: false,
    breaks: false,
    extensions: null,
    gfm: true,
    hooks: null,
    pedantic: false,
    renderer: null,
    silent: false,
    tokenizer: null,
    walkTokens: null
  };
}
var _defaults = _getDefaults();
function changeDefaults(newDefaults) {
  _defaults = newDefaults;
}
var escapeTest = /[&<>"']/;
var escapeReplace = new RegExp(escapeTest.source, "g");
var escapeTestNoEncode = /[<>"']|&(?!(#\d{1,7}|#[Xx][a-fA-F0-9]{1,6}|\w+);)/;
var escapeReplaceNoEncode = new RegExp(escapeTestNoEncode.source, "g");
var escapeReplacements = {
  "&": "&amp;",
  "<": "&lt;",
  ">": "&gt;",
  '"': "&quot;",
  "'": "&#39;"
};
var getEscapeReplacement = (ch) => escapeReplacements[ch];
function escape$1(html2, encode) {
  if (encode) {
    if (escapeTest.test(html2)) {
      return html2.replace(escapeReplace, getEscapeReplacement);
    }
  } else {
    if (escapeTestNoEncode.test(html2)) {
      return html2.replace(escapeReplaceNoEncode, getEscapeReplacement);
    }
  }
  return html2;
}
var unescapeTest = /&(#(?:\d+)|(?:#x[0-9A-Fa-f]+)|(?:\w+));?/ig;
function unescape(html2) {
  return html2.replace(unescapeTest, (_, n) => {
    n = n.toLowerCase();
    if (n === "colon")
      return ":";
    if (n.charAt(0) === "#") {
      return n.charAt(1) === "x" ? String.fromCharCode(parseInt(n.substring(2), 16)) : String.fromCharCode(+n.substring(1));
    }
    return "";
  });
}
var caret = /(^|[^\[])\^/g;
function edit(regex, opt) {
  let source = typeof regex === "string" ? regex : regex.source;
  opt = opt || "";
  const obj = {
    replace: (name, val) => {
      let valSource = typeof val === "string" ? val : val.source;
      valSource = valSource.replace(caret, "$1");
      source = source.replace(name, valSource);
      return obj;
    },
    getRegex: () => {
      return new RegExp(source, opt);
    }
  };
  return obj;
}
function cleanUrl(href) {
  try {
    href = encodeURI(href).replace(/%25/g, "%");
  } catch (e) {
    return null;
  }
  return href;
}
var noopTest = { exec: () => null };
function splitCells(tableRow, count) {
  const row = tableRow.replace(/\|/g, (match, offset, str) => {
    let escaped = false;
    let curr = offset;
    while (--curr >= 0 && str[curr] === "\\")
      escaped = !escaped;
    if (escaped) {
      return "|";
    } else {
      return " |";
    }
  }), cells = row.split(/ \|/);
  let i = 0;
  if (!cells[0].trim()) {
    cells.shift();
  }
  if (cells.length > 0 && !cells[cells.length - 1].trim()) {
    cells.pop();
  }
  if (count) {
    if (cells.length > count) {
      cells.splice(count);
    } else {
      while (cells.length < count)
        cells.push("");
    }
  }
  for (; i < cells.length; i++) {
    cells[i] = cells[i].trim().replace(/\\\|/g, "|");
  }
  return cells;
}
function rtrim(str, c, invert) {
  const l = str.length;
  if (l === 0) {
    return "";
  }
  let suffLen = 0;
  while (suffLen < l) {
    const currChar = str.charAt(l - suffLen - 1);
    if (currChar === c && !invert) {
      suffLen++;
    } else if (currChar !== c && invert) {
      suffLen++;
    } else {
      break;
    }
  }
  return str.slice(0, l - suffLen);
}
function findClosingBracket(str, b) {
  if (str.indexOf(b[1]) === -1) {
    return -1;
  }
  let level = 0;
  for (let i = 0; i < str.length; i++) {
    if (str[i] === "\\") {
      i++;
    } else if (str[i] === b[0]) {
      level++;
    } else if (str[i] === b[1]) {
      level--;
      if (level < 0) {
        return i;
      }
    }
  }
  return -1;
}
function outputLink(cap, link2, raw, lexer2) {
  const href = link2.href;
  const title = link2.title ? escape$1(link2.title) : null;
  const text = cap[1].replace(/\\([\[\]])/g, "$1");
  if (cap[0].charAt(0) !== "!") {
    lexer2.state.inLink = true;
    const token = {
      type: "link",
      raw,
      href,
      title,
      text,
      tokens: lexer2.inlineTokens(text)
    };
    lexer2.state.inLink = false;
    return token;
  }
  return {
    type: "image",
    raw,
    href,
    title,
    text: escape$1(text)
  };
}
function indentCodeCompensation(raw, text) {
  const matchIndentToCode = raw.match(/^(\s+)(?:```)/);
  if (matchIndentToCode === null) {
    return text;
  }
  const indentToCode = matchIndentToCode[1];
  return text.split("\n").map((node) => {
    const matchIndentInNode = node.match(/^\s+/);
    if (matchIndentInNode === null) {
      return node;
    }
    const [indentInNode] = matchIndentInNode;
    if (indentInNode.length >= indentToCode.length) {
      return node.slice(indentToCode.length);
    }
    return node;
  }).join("\n");
}
var _Tokenizer = class {
  options;
  rules;
  // set by the lexer
  lexer;
  // set by the lexer
  constructor(options2) {
    this.options = options2 || _defaults;
  }
  space(src) {
    const cap = this.rules.block.newline.exec(src);
    if (cap && cap[0].length > 0) {
      return {
        type: "space",
        raw: cap[0]
      };
    }
  }
  code(src) {
    const cap = this.rules.block.code.exec(src);
    if (cap) {
      const text = cap[0].replace(/^ {1,4}/gm, "");
      return {
        type: "code",
        raw: cap[0],
        codeBlockStyle: "indented",
        text: !this.options.pedantic ? rtrim(text, "\n") : text
      };
    }
  }
  fences(src) {
    const cap = this.rules.block.fences.exec(src);
    if (cap) {
      const raw = cap[0];
      const text = indentCodeCompensation(raw, cap[3] || "");
      return {
        type: "code",
        raw,
        lang: cap[2] ? cap[2].trim().replace(this.rules.inline.anyPunctuation, "$1") : cap[2],
        text
      };
    }
  }
  heading(src) {
    const cap = this.rules.block.heading.exec(src);
    if (cap) {
      let text = cap[2].trim();
      if (/#$/.test(text)) {
        const trimmed = rtrim(text, "#");
        if (this.options.pedantic) {
          text = trimmed.trim();
        } else if (!trimmed || / $/.test(trimmed)) {
          text = trimmed.trim();
        }
      }
      return {
        type: "heading",
        raw: cap[0],
        depth: cap[1].length,
        text,
        tokens: this.lexer.inline(text)
      };
    }
  }
  hr(src) {
    const cap = this.rules.block.hr.exec(src);
    if (cap) {
      return {
        type: "hr",
        raw: cap[0]
      };
    }
  }
  blockquote(src) {
    const cap = this.rules.block.blockquote.exec(src);
    if (cap) {
      const text = rtrim(cap[0].replace(/^ *>[ \t]?/gm, ""), "\n");
      const top = this.lexer.state.top;
      this.lexer.state.top = true;
      const tokens = this.lexer.blockTokens(text);
      this.lexer.state.top = top;
      return {
        type: "blockquote",
        raw: cap[0],
        tokens,
        text
      };
    }
  }
  list(src) {
    let cap = this.rules.block.list.exec(src);
    if (cap) {
      let bull = cap[1].trim();
      const isordered = bull.length > 1;
      const list2 = {
        type: "list",
        raw: "",
        ordered: isordered,
        start: isordered ? +bull.slice(0, -1) : "",
        loose: false,
        items: []
      };
      bull = isordered ? `\\d{1,9}\\${bull.slice(-1)}` : `\\${bull}`;
      if (this.options.pedantic) {
        bull = isordered ? bull : "[*+-]";
      }
      const itemRegex = new RegExp(`^( {0,3}${bull})((?:[	 ][^\\n]*)?(?:\\n|$))`);
      let raw = "";
      let itemContents = "";
      let endsWithBlankLine = false;
      while (src) {
        let endEarly = false;
        if (!(cap = itemRegex.exec(src))) {
          break;
        }
        if (this.rules.block.hr.test(src)) {
          break;
        }
        raw = cap[0];
        src = src.substring(raw.length);
        let line = cap[2].split("\n", 1)[0].replace(/^\t+/, (t) => " ".repeat(3 * t.length));
        let nextLine = src.split("\n", 1)[0];
        let indent = 0;
        if (this.options.pedantic) {
          indent = 2;
          itemContents = line.trimStart();
        } else {
          indent = cap[2].search(/[^ ]/);
          indent = indent > 4 ? 1 : indent;
          itemContents = line.slice(indent);
          indent += cap[1].length;
        }
        let blankLine = false;
        if (!line && /^ *$/.test(nextLine)) {
          raw += nextLine + "\n";
          src = src.substring(nextLine.length + 1);
          endEarly = true;
        }
        if (!endEarly) {
          const nextBulletRegex = new RegExp(`^ {0,${Math.min(3, indent - 1)}}(?:[*+-]|\\d{1,9}[.)])((?:[ 	][^\\n]*)?(?:\\n|$))`);
          const hrRegex = new RegExp(`^ {0,${Math.min(3, indent - 1)}}((?:- *){3,}|(?:_ *){3,}|(?:\\* *){3,})(?:\\n+|$)`);
          const fencesBeginRegex = new RegExp(`^ {0,${Math.min(3, indent - 1)}}(?:\`\`\`|~~~)`);
          const headingBeginRegex = new RegExp(`^ {0,${Math.min(3, indent - 1)}}#`);
          while (src) {
            const rawLine = src.split("\n", 1)[0];
            nextLine = rawLine;
            if (this.options.pedantic) {
              nextLine = nextLine.replace(/^ {1,4}(?=( {4})*[^ ])/g, "  ");
            }
            if (fencesBeginRegex.test(nextLine)) {
              break;
            }
            if (headingBeginRegex.test(nextLine)) {
              break;
            }
            if (nextBulletRegex.test(nextLine)) {
              break;
            }
            if (hrRegex.test(src)) {
              break;
            }
            if (nextLine.search(/[^ ]/) >= indent || !nextLine.trim()) {
              itemContents += "\n" + nextLine.slice(indent);
            } else {
              if (blankLine) {
                break;
              }
              if (line.search(/[^ ]/) >= 4) {
                break;
              }
              if (fencesBeginRegex.test(line)) {
                break;
              }
              if (headingBeginRegex.test(line)) {
                break;
              }
              if (hrRegex.test(line)) {
                break;
              }
              itemContents += "\n" + nextLine;
            }
            if (!blankLine && !nextLine.trim()) {
              blankLine = true;
            }
            raw += rawLine + "\n";
            src = src.substring(rawLine.length + 1);
            line = nextLine.slice(indent);
          }
        }
        if (!list2.loose) {
          if (endsWithBlankLine) {
            list2.loose = true;
          } else if (/\n *\n *$/.test(raw)) {
            endsWithBlankLine = true;
          }
        }
        let istask = null;
        let ischecked;
        if (this.options.gfm) {
          istask = /^\[[ xX]\] /.exec(itemContents);
          if (istask) {
            ischecked = istask[0] !== "[ ] ";
            itemContents = itemContents.replace(/^\[[ xX]\] +/, "");
          }
        }
        list2.items.push({
          type: "list_item",
          raw,
          task: !!istask,
          checked: ischecked,
          loose: false,
          text: itemContents,
          tokens: []
        });
        list2.raw += raw;
      }
      list2.items[list2.items.length - 1].raw = raw.trimEnd();
      list2.items[list2.items.length - 1].text = itemContents.trimEnd();
      list2.raw = list2.raw.trimEnd();
      for (let i = 0; i < list2.items.length; i++) {
        this.lexer.state.top = false;
        list2.items[i].tokens = this.lexer.blockTokens(list2.items[i].text, []);
        if (!list2.loose) {
          const spacers = list2.items[i].tokens.filter((t) => t.type === "space");
          const hasMultipleLineBreaks = spacers.length > 0 && spacers.some((t) => /\n.*\n/.test(t.raw));
          list2.loose = hasMultipleLineBreaks;
        }
      }
      if (list2.loose) {
        for (let i = 0; i < list2.items.length; i++) {
          list2.items[i].loose = true;
        }
      }
      return list2;
    }
  }
  html(src) {
    const cap = this.rules.block.html.exec(src);
    if (cap) {
      const token = {
        type: "html",
        block: true,
        raw: cap[0],
        pre: cap[1] === "pre" || cap[1] === "script" || cap[1] === "style",
        text: cap[0]
      };
      return token;
    }
  }
  def(src) {
    const cap = this.rules.block.def.exec(src);
    if (cap) {
      const tag2 = cap[1].toLowerCase().replace(/\s+/g, " ");
      const href = cap[2] ? cap[2].replace(/^<(.*)>$/, "$1").replace(this.rules.inline.anyPunctuation, "$1") : "";
      const title = cap[3] ? cap[3].substring(1, cap[3].length - 1).replace(this.rules.inline.anyPunctuation, "$1") : cap[3];
      return {
        type: "def",
        tag: tag2,
        raw: cap[0],
        href,
        title
      };
    }
  }
  table(src) {
    const cap = this.rules.block.table.exec(src);
    if (!cap) {
      return;
    }
    if (!/[:|]/.test(cap[2])) {
      return;
    }
    const headers = splitCells(cap[1]);
    const aligns = cap[2].replace(/^\||\| *$/g, "").split("|");
    const rows = cap[3] && cap[3].trim() ? cap[3].replace(/\n[ \t]*$/, "").split("\n") : [];
    const item = {
      type: "table",
      raw: cap[0],
      header: [],
      align: [],
      rows: []
    };
    if (headers.length !== aligns.length) {
      return;
    }
    for (const align of aligns) {
      if (/^ *-+: *$/.test(align)) {
        item.align.push("right");
      } else if (/^ *:-+: *$/.test(align)) {
        item.align.push("center");
      } else if (/^ *:-+ *$/.test(align)) {
        item.align.push("left");
      } else {
        item.align.push(null);
      }
    }
    for (const header of headers) {
      item.header.push({
        text: header,
        tokens: this.lexer.inline(header)
      });
    }
    for (const row of rows) {
      item.rows.push(splitCells(row, item.header.length).map((cell) => {
        return {
          text: cell,
          tokens: this.lexer.inline(cell)
        };
      }));
    }
    return item;
  }
  lheading(src) {
    const cap = this.rules.block.lheading.exec(src);
    if (cap) {
      return {
        type: "heading",
        raw: cap[0],
        depth: cap[2].charAt(0) === "=" ? 1 : 2,
        text: cap[1],
        tokens: this.lexer.inline(cap[1])
      };
    }
  }
  paragraph(src) {
    const cap = this.rules.block.paragraph.exec(src);
    if (cap) {
      const text = cap[1].charAt(cap[1].length - 1) === "\n" ? cap[1].slice(0, -1) : cap[1];
      return {
        type: "paragraph",
        raw: cap[0],
        text,
        tokens: this.lexer.inline(text)
      };
    }
  }
  text(src) {
    const cap = this.rules.block.text.exec(src);
    if (cap) {
      return {
        type: "text",
        raw: cap[0],
        text: cap[0],
        tokens: this.lexer.inline(cap[0])
      };
    }
  }
  escape(src) {
    const cap = this.rules.inline.escape.exec(src);
    if (cap) {
      return {
        type: "escape",
        raw: cap[0],
        text: escape$1(cap[1])
      };
    }
  }
  tag(src) {
    const cap = this.rules.inline.tag.exec(src);
    if (cap) {
      if (!this.lexer.state.inLink && /^<a /i.test(cap[0])) {
        this.lexer.state.inLink = true;
      } else if (this.lexer.state.inLink && /^<\/a>/i.test(cap[0])) {
        this.lexer.state.inLink = false;
      }
      if (!this.lexer.state.inRawBlock && /^<(pre|code|kbd|script)(\s|>)/i.test(cap[0])) {
        this.lexer.state.inRawBlock = true;
      } else if (this.lexer.state.inRawBlock && /^<\/(pre|code|kbd|script)(\s|>)/i.test(cap[0])) {
        this.lexer.state.inRawBlock = false;
      }
      return {
        type: "html",
        raw: cap[0],
        inLink: this.lexer.state.inLink,
        inRawBlock: this.lexer.state.inRawBlock,
        block: false,
        text: cap[0]
      };
    }
  }
  link(src) {
    const cap = this.rules.inline.link.exec(src);
    if (cap) {
      const trimmedUrl = cap[2].trim();
      if (!this.options.pedantic && /^</.test(trimmedUrl)) {
        if (!/>$/.test(trimmedUrl)) {
          return;
        }
        const rtrimSlash = rtrim(trimmedUrl.slice(0, -1), "\\");
        if ((trimmedUrl.length - rtrimSlash.length) % 2 === 0) {
          return;
        }
      } else {
        const lastParenIndex = findClosingBracket(cap[2], "()");
        if (lastParenIndex > -1) {
          const start = cap[0].indexOf("!") === 0 ? 5 : 4;
          const linkLen = start + cap[1].length + lastParenIndex;
          cap[2] = cap[2].substring(0, lastParenIndex);
          cap[0] = cap[0].substring(0, linkLen).trim();
          cap[3] = "";
        }
      }
      let href = cap[2];
      let title = "";
      if (this.options.pedantic) {
        const link2 = /^([^'"]*[^\s])\s+(['"])(.*)\2/.exec(href);
        if (link2) {
          href = link2[1];
          title = link2[3];
        }
      } else {
        title = cap[3] ? cap[3].slice(1, -1) : "";
      }
      href = href.trim();
      if (/^</.test(href)) {
        if (this.options.pedantic && !/>$/.test(trimmedUrl)) {
          href = href.slice(1);
        } else {
          href = href.slice(1, -1);
        }
      }
      return outputLink(cap, {
        href: href ? href.replace(this.rules.inline.anyPunctuation, "$1") : href,
        title: title ? title.replace(this.rules.inline.anyPunctuation, "$1") : title
      }, cap[0], this.lexer);
    }
  }
  reflink(src, links) {
    let cap;
    if ((cap = this.rules.inline.reflink.exec(src)) || (cap = this.rules.inline.nolink.exec(src))) {
      const linkString = (cap[2] || cap[1]).replace(/\s+/g, " ");
      const link2 = links[linkString.toLowerCase()];
      if (!link2) {
        const text = cap[0].charAt(0);
        return {
          type: "text",
          raw: text,
          text
        };
      }
      return outputLink(cap, link2, cap[0], this.lexer);
    }
  }
  emStrong(src, maskedSrc, prevChar = "") {
    let match = this.rules.inline.emStrongLDelim.exec(src);
    if (!match)
      return;
    if (match[3] && prevChar.match(/[\p{L}\p{N}]/u))
      return;
    const nextChar = match[1] || match[2] || "";
    if (!nextChar || !prevChar || this.rules.inline.punctuation.exec(prevChar)) {
      const lLength = [...match[0]].length - 1;
      let rDelim, rLength, delimTotal = lLength, midDelimTotal = 0;
      const endReg = match[0][0] === "*" ? this.rules.inline.emStrongRDelimAst : this.rules.inline.emStrongRDelimUnd;
      endReg.lastIndex = 0;
      maskedSrc = maskedSrc.slice(-1 * src.length + lLength);
      while ((match = endReg.exec(maskedSrc)) != null) {
        rDelim = match[1] || match[2] || match[3] || match[4] || match[5] || match[6];
        if (!rDelim)
          continue;
        rLength = [...rDelim].length;
        if (match[3] || match[4]) {
          delimTotal += rLength;
          continue;
        } else if (match[5] || match[6]) {
          if (lLength % 3 && !((lLength + rLength) % 3)) {
            midDelimTotal += rLength;
            continue;
          }
        }
        delimTotal -= rLength;
        if (delimTotal > 0)
          continue;
        rLength = Math.min(rLength, rLength + delimTotal + midDelimTotal);
        const lastCharLength = [...match[0]][0].length;
        const raw = src.slice(0, lLength + match.index + lastCharLength + rLength);
        if (Math.min(lLength, rLength) % 2) {
          const text2 = raw.slice(1, -1);
          return {
            type: "em",
            raw,
            text: text2,
            tokens: this.lexer.inlineTokens(text2)
          };
        }
        const text = raw.slice(2, -2);
        return {
          type: "strong",
          raw,
          text,
          tokens: this.lexer.inlineTokens(text)
        };
      }
    }
  }
  codespan(src) {
    const cap = this.rules.inline.code.exec(src);
    if (cap) {
      let text = cap[2].replace(/\n/g, " ");
      const hasNonSpaceChars = /[^ ]/.test(text);
      const hasSpaceCharsOnBothEnds = /^ /.test(text) && / $/.test(text);
      if (hasNonSpaceChars && hasSpaceCharsOnBothEnds) {
        text = text.substring(1, text.length - 1);
      }
      text = escape$1(text, true);
      return {
        type: "codespan",
        raw: cap[0],
        text
      };
    }
  }
  br(src) {
    const cap = this.rules.inline.br.exec(src);
    if (cap) {
      return {
        type: "br",
        raw: cap[0]
      };
    }
  }
  del(src) {
    const cap = this.rules.inline.del.exec(src);
    if (cap) {
      return {
        type: "del",
        raw: cap[0],
        text: cap[2],
        tokens: this.lexer.inlineTokens(cap[2])
      };
    }
  }
  autolink(src) {
    const cap = this.rules.inline.autolink.exec(src);
    if (cap) {
      let text, href;
      if (cap[2] === "@") {
        text = escape$1(cap[1]);
        href = "mailto:" + text;
      } else {
        text = escape$1(cap[1]);
        href = text;
      }
      return {
        type: "link",
        raw: cap[0],
        text,
        href,
        tokens: [
          {
            type: "text",
            raw: text,
            text
          }
        ]
      };
    }
  }
  url(src) {
    let cap;
    if (cap = this.rules.inline.url.exec(src)) {
      let text, href;
      if (cap[2] === "@") {
        text = escape$1(cap[0]);
        href = "mailto:" + text;
      } else {
        let prevCapZero;
        do {
          prevCapZero = cap[0];
          cap[0] = this.rules.inline._backpedal.exec(cap[0])?.[0] ?? "";
        } while (prevCapZero !== cap[0]);
        text = escape$1(cap[0]);
        if (cap[1] === "www.") {
          href = "http://" + cap[0];
        } else {
          href = cap[0];
        }
      }
      return {
        type: "link",
        raw: cap[0],
        text,
        href,
        tokens: [
          {
            type: "text",
            raw: text,
            text
          }
        ]
      };
    }
  }
  inlineText(src) {
    const cap = this.rules.inline.text.exec(src);
    if (cap) {
      let text;
      if (this.lexer.state.inRawBlock) {
        text = cap[0];
      } else {
        text = escape$1(cap[0]);
      }
      return {
        type: "text",
        raw: cap[0],
        text
      };
    }
  }
};
var newline = /^(?: *(?:\n|$))+/;
var blockCode = /^( {4}[^\n]+(?:\n(?: *(?:\n|$))*)?)+/;
var fences = /^ {0,3}(`{3,}(?=[^`\n]*(?:\n|$))|~{3,})([^\n]*)(?:\n|$)(?:|([\s\S]*?)(?:\n|$))(?: {0,3}\1[~`]* *(?=\n|$)|$)/;
var hr = /^ {0,3}((?:-[\t ]*){3,}|(?:_[ \t]*){3,}|(?:\*[ \t]*){3,})(?:\n+|$)/;
var heading = /^ {0,3}(#{1,6})(?=\s|$)(.*)(?:\n+|$)/;
var bullet = /(?:[*+-]|\d{1,9}[.)])/;
var lheading = edit(/^(?!bull )((?:.|\n(?!\s*?\n|bull ))+?)\n {0,3}(=+|-+) *(?:\n+|$)/).replace(/bull/g, bullet).getRegex();
var _paragraph = /^([^\n]+(?:\n(?!hr|heading|lheading|blockquote|fences|list|html|table| +\n)[^\n]+)*)/;
var blockText = /^[^\n]+/;
var _blockLabel = /(?!\s*\])(?:\\.|[^\[\]\\])+/;
var def = edit(/^ {0,3}\[(label)\]: *(?:\n *)?([^<\s][^\s]*|<.*?>)(?:(?: +(?:\n *)?| *\n *)(title))? *(?:\n+|$)/).replace("label", _blockLabel).replace("title", /(?:"(?:\\"?|[^"\\])*"|'[^'\n]*(?:\n[^'\n]+)*\n?'|\([^()]*\))/).getRegex();
var list = edit(/^( {0,3}bull)([ \t][^\n]+?)?(?:\n|$)/).replace(/bull/g, bullet).getRegex();
var _tag = "address|article|aside|base|basefont|blockquote|body|caption|center|col|colgroup|dd|details|dialog|dir|div|dl|dt|fieldset|figcaption|figure|footer|form|frame|frameset|h[1-6]|head|header|hr|html|iframe|legend|li|link|main|menu|menuitem|meta|nav|noframes|ol|optgroup|option|p|param|section|source|summary|table|tbody|td|tfoot|th|thead|title|tr|track|ul";
var _comment = /<!--(?!-?>)[\s\S]*?(?:-->|$)/;
var html = edit("^ {0,3}(?:<(script|pre|style|textarea)[\\s>][\\s\\S]*?(?:</\\1>[^\\n]*\\n+|$)|comment[^\\n]*(\\n+|$)|<\\?[\\s\\S]*?(?:\\?>\\n*|$)|<![A-Z][\\s\\S]*?(?:>\\n*|$)|<!\\[CDATA\\[[\\s\\S]*?(?:\\]\\]>\\n*|$)|</?(tag)(?: +|\\n|/?>)[\\s\\S]*?(?:(?:\\n *)+\\n|$)|<(?!script|pre|style|textarea)([a-z][\\w-]*)(?:attribute)*? */?>(?=[ \\t]*(?:\\n|$))[\\s\\S]*?(?:(?:\\n *)+\\n|$)|</(?!script|pre|style|textarea)[a-z][\\w-]*\\s*>(?=[ \\t]*(?:\\n|$))[\\s\\S]*?(?:(?:\\n *)+\\n|$))", "i").replace("comment", _comment).replace("tag", _tag).replace("attribute", / +[a-zA-Z:_][\w.:-]*(?: *= *"[^"\n]*"| *= *'[^'\n]*'| *= *[^\s"'=<>`]+)?/).getRegex();
var paragraph = edit(_paragraph).replace("hr", hr).replace("heading", " {0,3}#{1,6}(?:\\s|$)").replace("|lheading", "").replace("|table", "").replace("blockquote", " {0,3}>").replace("fences", " {0,3}(?:`{3,}(?=[^`\\n]*\\n)|~{3,})[^\\n]*\\n").replace("list", " {0,3}(?:[*+-]|1[.)]) ").replace("html", "</?(?:tag)(?: +|\\n|/?>)|<(?:script|pre|style|textarea|!--)").replace("tag", _tag).getRegex();
var blockquote = edit(/^( {0,3}> ?(paragraph|[^\n]*)(?:\n|$))+/).replace("paragraph", paragraph).getRegex();
var blockNormal = {
  blockquote,
  code: blockCode,
  def,
  fences,
  heading,
  hr,
  html,
  lheading,
  list,
  newline,
  paragraph,
  table: noopTest,
  text: blockText
};
var gfmTable = edit("^ *([^\\n ].*)\\n {0,3}((?:\\| *)?:?-+:? *(?:\\| *:?-+:? *)*(?:\\| *)?)(?:\\n((?:(?! *\\n|hr|heading|blockquote|code|fences|list|html).*(?:\\n|$))*)\\n*|$)").replace("hr", hr).replace("heading", " {0,3}#{1,6}(?:\\s|$)").replace("blockquote", " {0,3}>").replace("code", " {4}[^\\n]").replace("fences", " {0,3}(?:`{3,}(?=[^`\\n]*\\n)|~{3,})[^\\n]*\\n").replace("list", " {0,3}(?:[*+-]|1[.)]) ").replace("html", "</?(?:tag)(?: +|\\n|/?>)|<(?:script|pre|style|textarea|!--)").replace("tag", _tag).getRegex();
var blockGfm = {
  ...blockNormal,
  table: gfmTable,
  paragraph: edit(_paragraph).replace("hr", hr).replace("heading", " {0,3}#{1,6}(?:\\s|$)").replace("|lheading", "").replace("table", gfmTable).replace("blockquote", " {0,3}>").replace("fences", " {0,3}(?:`{3,}(?=[^`\\n]*\\n)|~{3,})[^\\n]*\\n").replace("list", " {0,3}(?:[*+-]|1[.)]) ").replace("html", "</?(?:tag)(?: +|\\n|/?>)|<(?:script|pre|style|textarea|!--)").replace("tag", _tag).getRegex()
};
var blockPedantic = {
  ...blockNormal,
  html: edit(`^ *(?:comment *(?:\\n|\\s*$)|<(tag)[\\s\\S]+?</\\1> *(?:\\n{2,}|\\s*$)|<tag(?:"[^"]*"|'[^']*'|\\s[^'"/>\\s]*)*?/?> *(?:\\n{2,}|\\s*$))`).replace("comment", _comment).replace(/tag/g, "(?!(?:a|em|strong|small|s|cite|q|dfn|abbr|data|time|code|var|samp|kbd|sub|sup|i|b|u|mark|ruby|rt|rp|bdi|bdo|span|br|wbr|ins|del|img)\\b)\\w+(?!:|[^\\w\\s@]*@)\\b").getRegex(),
  def: /^ *\[([^\]]+)\]: *<?([^\s>]+)>?(?: +(["(][^\n]+[")]))? *(?:\n+|$)/,
  heading: /^(#{1,6})(.*)(?:\n+|$)/,
  fences: noopTest,
  // fences not supported
  lheading: /^(.+?)\n {0,3}(=+|-+) *(?:\n+|$)/,
  paragraph: edit(_paragraph).replace("hr", hr).replace("heading", " *#{1,6} *[^\n]").replace("lheading", lheading).replace("|table", "").replace("blockquote", " {0,3}>").replace("|fences", "").replace("|list", "").replace("|html", "").replace("|tag", "").getRegex()
};
var escape = /^\\([!"#$%&'()*+,\-./:;<=>?@\[\]\\^_`{|}~])/;
var inlineCode = /^(`+)([^`]|[^`][\s\S]*?[^`])\1(?!`)/;
var br = /^( {2,}|\\)\n(?!\s*$)/;
var inlineText = /^(`+|[^`])(?:(?= {2,}\n)|[\s\S]*?(?:(?=[\\<!\[`*_]|\b_|$)|[^ ](?= {2,}\n)))/;
var _punctuation = "\\p{P}$+<=>`^|~";
var punctuation = edit(/^((?![*_])[\spunctuation])/, "u").replace(/punctuation/g, _punctuation).getRegex();
var blockSkip = /\[[^[\]]*?\]\([^\(\)]*?\)|`[^`]*?`|<[^<>]*?>/g;
var emStrongLDelim = edit(/^(?:\*+(?:((?!\*)[punct])|[^\s*]))|^_+(?:((?!_)[punct])|([^\s_]))/, "u").replace(/punct/g, _punctuation).getRegex();
var emStrongRDelimAst = edit("^[^_*]*?__[^_*]*?\\*[^_*]*?(?=__)|[^*]+(?=[^*])|(?!\\*)[punct](\\*+)(?=[\\s]|$)|[^punct\\s](\\*+)(?!\\*)(?=[punct\\s]|$)|(?!\\*)[punct\\s](\\*+)(?=[^punct\\s])|[\\s](\\*+)(?!\\*)(?=[punct])|(?!\\*)[punct](\\*+)(?!\\*)(?=[punct])|[^punct\\s](\\*+)(?=[^punct\\s])", "gu").replace(/punct/g, _punctuation).getRegex();
var emStrongRDelimUnd = edit("^[^_*]*?\\*\\*[^_*]*?_[^_*]*?(?=\\*\\*)|[^_]+(?=[^_])|(?!_)[punct](_+)(?=[\\s]|$)|[^punct\\s](_+)(?!_)(?=[punct\\s]|$)|(?!_)[punct\\s](_+)(?=[^punct\\s])|[\\s](_+)(?!_)(?=[punct])|(?!_)[punct](_+)(?!_)(?=[punct])", "gu").replace(/punct/g, _punctuation).getRegex();
var anyPunctuation = edit(/\\([punct])/, "gu").replace(/punct/g, _punctuation).getRegex();
var autolink = edit(/^<(scheme:[^\s\x00-\x1f<>]*|email)>/).replace("scheme", /[a-zA-Z][a-zA-Z0-9+.-]{1,31}/).replace("email", /[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(@)[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+(?![-_])/).getRegex();
var _inlineComment = edit(_comment).replace("(?:-->|$)", "-->").getRegex();
var tag = edit("^comment|^</[a-zA-Z][\\w:-]*\\s*>|^<[a-zA-Z][\\w-]*(?:attribute)*?\\s*/?>|^<\\?[\\s\\S]*?\\?>|^<![a-zA-Z]+\\s[\\s\\S]*?>|^<!\\[CDATA\\[[\\s\\S]*?\\]\\]>").replace("comment", _inlineComment).replace("attribute", /\s+[a-zA-Z:_][\w.:-]*(?:\s*=\s*"[^"]*"|\s*=\s*'[^']*'|\s*=\s*[^\s"'=<>`]+)?/).getRegex();
var _inlineLabel = /(?:\[(?:\\.|[^\[\]\\])*\]|\\.|`[^`]*`|[^\[\]\\`])*?/;
var link = edit(/^!?\[(label)\]\(\s*(href)(?:\s+(title))?\s*\)/).replace("label", _inlineLabel).replace("href", /<(?:\\.|[^\n<>\\])+>|[^\s\x00-\x1f]*/).replace("title", /"(?:\\"?|[^"\\])*"|'(?:\\'?|[^'\\])*'|\((?:\\\)?|[^)\\])*\)/).getRegex();
var reflink = edit(/^!?\[(label)\]\[(ref)\]/).replace("label", _inlineLabel).replace("ref", _blockLabel).getRegex();
var nolink = edit(/^!?\[(ref)\](?:\[\])?/).replace("ref", _blockLabel).getRegex();
var reflinkSearch = edit("reflink|nolink(?!\\()", "g").replace("reflink", reflink).replace("nolink", nolink).getRegex();
var inlineNormal = {
  _backpedal: noopTest,
  // only used for GFM url
  anyPunctuation,
  autolink,
  blockSkip,
  br,
  code: inlineCode,
  del: noopTest,
  emStrongLDelim,
  emStrongRDelimAst,
  emStrongRDelimUnd,
  escape,
  link,
  nolink,
  punctuation,
  reflink,
  reflinkSearch,
  tag,
  text: inlineText,
  url: noopTest
};
var inlinePedantic = {
  ...inlineNormal,
  link: edit(/^!?\[(label)\]\((.*?)\)/).replace("label", _inlineLabel).getRegex(),
  reflink: edit(/^!?\[(label)\]\s*\[([^\]]*)\]/).replace("label", _inlineLabel).getRegex()
};
var inlineGfm = {
  ...inlineNormal,
  escape: edit(escape).replace("])", "~|])").getRegex(),
  url: edit(/^((?:ftp|https?):\/\/|www\.)(?:[a-zA-Z0-9\-]+\.?)+[^\s<]*|^email/, "i").replace("email", /[A-Za-z0-9._+-]+(@)[a-zA-Z0-9-_]+(?:\.[a-zA-Z0-9-_]*[a-zA-Z0-9])+(?![-_])/).getRegex(),
  _backpedal: /(?:[^?!.,:;*_'"~()&]+|\([^)]*\)|&(?![a-zA-Z0-9]+;$)|[?!.,:;*_'"~)]+(?!$))+/,
  del: /^(~~?)(?=[^\s~])([\s\S]*?[^\s~])\1(?=[^~]|$)/,
  text: /^([`~]+|[^`~])(?:(?= {2,}\n)|(?=[a-zA-Z0-9.!#$%&'*+\/=?_`{\|}~-]+@)|[\s\S]*?(?:(?=[\\<!\[`*~_]|\b_|https?:\/\/|ftp:\/\/|www\.|$)|[^ ](?= {2,}\n)|[^a-zA-Z0-9.!#$%&'*+\/=?_`{\|}~-](?=[a-zA-Z0-9.!#$%&'*+\/=?_`{\|}~-]+@)))/
};
var inlineBreaks = {
  ...inlineGfm,
  br: edit(br).replace("{2,}", "*").getRegex(),
  text: edit(inlineGfm.text).replace("\\b_", "\\b_| {2,}\\n").replace(/\{2,\}/g, "*").getRegex()
};
var block = {
  normal: blockNormal,
  gfm: blockGfm,
  pedantic: blockPedantic
};
var inline = {
  normal: inlineNormal,
  gfm: inlineGfm,
  breaks: inlineBreaks,
  pedantic: inlinePedantic
};
var _Lexer = class __Lexer {
  tokens;
  options;
  state;
  tokenizer;
  inlineQueue;
  constructor(options2) {
    this.tokens = [];
    this.tokens.links = /* @__PURE__ */ Object.create(null);
    this.options = options2 || _defaults;
    this.options.tokenizer = this.options.tokenizer || new _Tokenizer();
    this.tokenizer = this.options.tokenizer;
    this.tokenizer.options = this.options;
    this.tokenizer.lexer = this;
    this.inlineQueue = [];
    this.state = {
      inLink: false,
      inRawBlock: false,
      top: true
    };
    const rules = {
      block: block.normal,
      inline: inline.normal
    };
    if (this.options.pedantic) {
      rules.block = block.pedantic;
      rules.inline = inline.pedantic;
    } else if (this.options.gfm) {
      rules.block = block.gfm;
      if (this.options.breaks) {
        rules.inline = inline.breaks;
      } else {
        rules.inline = inline.gfm;
      }
    }
    this.tokenizer.rules = rules;
  }
  /**
   * Expose Rules
   */
  static get rules() {
    return {
      block,
      inline
    };
  }
  /**
   * Static Lex Method
   */
  static lex(src, options2) {
    const lexer2 = new __Lexer(options2);
    return lexer2.lex(src);
  }
  /**
   * Static Lex Inline Method
   */
  static lexInline(src, options2) {
    const lexer2 = new __Lexer(options2);
    return lexer2.inlineTokens(src);
  }
  /**
   * Preprocessing
   */
  lex(src) {
    src = src.replace(/\r\n|\r/g, "\n");
    this.blockTokens(src, this.tokens);
    for (let i = 0; i < this.inlineQueue.length; i++) {
      const next = this.inlineQueue[i];
      this.inlineTokens(next.src, next.tokens);
    }
    this.inlineQueue = [];
    return this.tokens;
  }
  blockTokens(src, tokens = []) {
    if (this.options.pedantic) {
      src = src.replace(/\t/g, "    ").replace(/^ +$/gm, "");
    } else {
      src = src.replace(/^( *)(\t+)/gm, (_, leading, tabs) => {
        return leading + "    ".repeat(tabs.length);
      });
    }
    let token;
    let lastToken;
    let cutSrc;
    let lastParagraphClipped;
    while (src) {
      if (this.options.extensions && this.options.extensions.block && this.options.extensions.block.some((extTokenizer) => {
        if (token = extTokenizer.call({ lexer: this }, src, tokens)) {
          src = src.substring(token.raw.length);
          tokens.push(token);
          return true;
        }
        return false;
      })) {
        continue;
      }
      if (token = this.tokenizer.space(src)) {
        src = src.substring(token.raw.length);
        if (token.raw.length === 1 && tokens.length > 0) {
          tokens[tokens.length - 1].raw += "\n";
        } else {
          tokens.push(token);
        }
        continue;
      }
      if (token = this.tokenizer.code(src)) {
        src = src.substring(token.raw.length);
        lastToken = tokens[tokens.length - 1];
        if (lastToken && (lastToken.type === "paragraph" || lastToken.type === "text")) {
          lastToken.raw += "\n" + token.raw;
          lastToken.text += "\n" + token.text;
          this.inlineQueue[this.inlineQueue.length - 1].src = lastToken.text;
        } else {
          tokens.push(token);
        }
        continue;
      }
      if (token = this.tokenizer.fences(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.heading(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.hr(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.blockquote(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.list(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.html(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.def(src)) {
        src = src.substring(token.raw.length);
        lastToken = tokens[tokens.length - 1];
        if (lastToken && (lastToken.type === "paragraph" || lastToken.type === "text")) {
          lastToken.raw += "\n" + token.raw;
          lastToken.text += "\n" + token.raw;
          this.inlineQueue[this.inlineQueue.length - 1].src = lastToken.text;
        } else if (!this.tokens.links[token.tag]) {
          this.tokens.links[token.tag] = {
            href: token.href,
            title: token.title
          };
        }
        continue;
      }
      if (token = this.tokenizer.table(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.lheading(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      cutSrc = src;
      if (this.options.extensions && this.options.extensions.startBlock) {
        let startIndex = Infinity;
        const tempSrc = src.slice(1);
        let tempStart;
        this.options.extensions.startBlock.forEach((getStartIndex) => {
          tempStart = getStartIndex.call({ lexer: this }, tempSrc);
          if (typeof tempStart === "number" && tempStart >= 0) {
            startIndex = Math.min(startIndex, tempStart);
          }
        });
        if (startIndex < Infinity && startIndex >= 0) {
          cutSrc = src.substring(0, startIndex + 1);
        }
      }
      if (this.state.top && (token = this.tokenizer.paragraph(cutSrc))) {
        lastToken = tokens[tokens.length - 1];
        if (lastParagraphClipped && lastToken.type === "paragraph") {
          lastToken.raw += "\n" + token.raw;
          lastToken.text += "\n" + token.text;
          this.inlineQueue.pop();
          this.inlineQueue[this.inlineQueue.length - 1].src = lastToken.text;
        } else {
          tokens.push(token);
        }
        lastParagraphClipped = cutSrc.length !== src.length;
        src = src.substring(token.raw.length);
        continue;
      }
      if (token = this.tokenizer.text(src)) {
        src = src.substring(token.raw.length);
        lastToken = tokens[tokens.length - 1];
        if (lastToken && lastToken.type === "text") {
          lastToken.raw += "\n" + token.raw;
          lastToken.text += "\n" + token.text;
          this.inlineQueue.pop();
          this.inlineQueue[this.inlineQueue.length - 1].src = lastToken.text;
        } else {
          tokens.push(token);
        }
        continue;
      }
      if (src) {
        const errMsg = "Infinite loop on byte: " + src.charCodeAt(0);
        if (this.options.silent) {
          console.error(errMsg);
          break;
        } else {
          throw new Error(errMsg);
        }
      }
    }
    this.state.top = true;
    return tokens;
  }
  inline(src, tokens = []) {
    this.inlineQueue.push({ src, tokens });
    return tokens;
  }
  /**
   * Lexing/Compiling
   */
  inlineTokens(src, tokens = []) {
    let token, lastToken, cutSrc;
    let maskedSrc = src;
    let match;
    let keepPrevChar, prevChar;
    if (this.tokens.links) {
      const links = Object.keys(this.tokens.links);
      if (links.length > 0) {
        while ((match = this.tokenizer.rules.inline.reflinkSearch.exec(maskedSrc)) != null) {
          if (links.includes(match[0].slice(match[0].lastIndexOf("[") + 1, -1))) {
            maskedSrc = maskedSrc.slice(0, match.index) + "[" + "a".repeat(match[0].length - 2) + "]" + maskedSrc.slice(this.tokenizer.rules.inline.reflinkSearch.lastIndex);
          }
        }
      }
    }
    while ((match = this.tokenizer.rules.inline.blockSkip.exec(maskedSrc)) != null) {
      maskedSrc = maskedSrc.slice(0, match.index) + "[" + "a".repeat(match[0].length - 2) + "]" + maskedSrc.slice(this.tokenizer.rules.inline.blockSkip.lastIndex);
    }
    while ((match = this.tokenizer.rules.inline.anyPunctuation.exec(maskedSrc)) != null) {
      maskedSrc = maskedSrc.slice(0, match.index) + "++" + maskedSrc.slice(this.tokenizer.rules.inline.anyPunctuation.lastIndex);
    }
    while (src) {
      if (!keepPrevChar) {
        prevChar = "";
      }
      keepPrevChar = false;
      if (this.options.extensions && this.options.extensions.inline && this.options.extensions.inline.some((extTokenizer) => {
        if (token = extTokenizer.call({ lexer: this }, src, tokens)) {
          src = src.substring(token.raw.length);
          tokens.push(token);
          return true;
        }
        return false;
      })) {
        continue;
      }
      if (token = this.tokenizer.escape(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.tag(src)) {
        src = src.substring(token.raw.length);
        lastToken = tokens[tokens.length - 1];
        if (lastToken && token.type === "text" && lastToken.type === "text") {
          lastToken.raw += token.raw;
          lastToken.text += token.text;
        } else {
          tokens.push(token);
        }
        continue;
      }
      if (token = this.tokenizer.link(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.reflink(src, this.tokens.links)) {
        src = src.substring(token.raw.length);
        lastToken = tokens[tokens.length - 1];
        if (lastToken && token.type === "text" && lastToken.type === "text") {
          lastToken.raw += token.raw;
          lastToken.text += token.text;
        } else {
          tokens.push(token);
        }
        continue;
      }
      if (token = this.tokenizer.emStrong(src, maskedSrc, prevChar)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.codespan(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.br(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.del(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (token = this.tokenizer.autolink(src)) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      if (!this.state.inLink && (token = this.tokenizer.url(src))) {
        src = src.substring(token.raw.length);
        tokens.push(token);
        continue;
      }
      cutSrc = src;
      if (this.options.extensions && this.options.extensions.startInline) {
        let startIndex = Infinity;
        const tempSrc = src.slice(1);
        let tempStart;
        this.options.extensions.startInline.forEach((getStartIndex) => {
          tempStart = getStartIndex.call({ lexer: this }, tempSrc);
          if (typeof tempStart === "number" && tempStart >= 0) {
            startIndex = Math.min(startIndex, tempStart);
          }
        });
        if (startIndex < Infinity && startIndex >= 0) {
          cutSrc = src.substring(0, startIndex + 1);
        }
      }
      if (token = this.tokenizer.inlineText(cutSrc)) {
        src = src.substring(token.raw.length);
        if (token.raw.slice(-1) !== "_") {
          prevChar = token.raw.slice(-1);
        }
        keepPrevChar = true;
        lastToken = tokens[tokens.length - 1];
        if (lastToken && lastToken.type === "text") {
          lastToken.raw += token.raw;
          lastToken.text += token.text;
        } else {
          tokens.push(token);
        }
        continue;
      }
      if (src) {
        const errMsg = "Infinite loop on byte: " + src.charCodeAt(0);
        if (this.options.silent) {
          console.error(errMsg);
          break;
        } else {
          throw new Error(errMsg);
        }
      }
    }
    return tokens;
  }
};
var _Renderer = class {
  options;
  constructor(options2) {
    this.options = options2 || _defaults;
  }
  code(code, infostring, escaped) {
    const lang = (infostring || "").match(/^\S*/)?.[0];
    code = code.replace(/\n$/, "") + "\n";
    if (!lang) {
      return "<pre><code>" + (escaped ? code : escape$1(code, true)) + "</code></pre>\n";
    }
    return '<pre><code class="language-' + escape$1(lang) + '">' + (escaped ? code : escape$1(code, true)) + "</code></pre>\n";
  }
  blockquote(quote) {
    return `<blockquote>
${quote}</blockquote>
`;
  }
  html(html2, block2) {
    return html2;
  }
  heading(text, level, raw) {
    return `<h${level}>${text}</h${level}>
`;
  }
  hr() {
    return "<hr>\n";
  }
  list(body, ordered, start) {
    const type = ordered ? "ol" : "ul";
    const startatt = ordered && start !== 1 ? ' start="' + start + '"' : "";
    return "<" + type + startatt + ">\n" + body + "</" + type + ">\n";
  }
  listitem(text, task, checked) {
    return `<li>${text}</li>
`;
  }
  checkbox(checked) {
    return "<input " + (checked ? 'checked="" ' : "") + 'disabled="" type="checkbox">';
  }
  paragraph(text) {
    return `<p>${text}</p>
`;
  }
  table(header, body) {
    if (body)
      body = `<tbody>${body}</tbody>`;
    return "<table>\n<thead>\n" + header + "</thead>\n" + body + "</table>\n";
  }
  tablerow(content) {
    return `<tr>
${content}</tr>
`;
  }
  tablecell(content, flags) {
    const type = flags.header ? "th" : "td";
    const tag2 = flags.align ? `<${type} align="${flags.align}">` : `<${type}>`;
    return tag2 + content + `</${type}>
`;
  }
  /**
   * span level renderer
   */
  strong(text) {
    return `<strong>${text}</strong>`;
  }
  em(text) {
    return `<em>${text}</em>`;
  }
  codespan(text) {
    return `<code>${text}</code>`;
  }
  br() {
    return "<br>";
  }
  del(text) {
    return `<del>${text}</del>`;
  }
  link(href, title, text) {
    const cleanHref = cleanUrl(href);
    if (cleanHref === null) {
      return text;
    }
    href = cleanHref;
    let out = '<a href="' + href + '"';
    if (title) {
      out += ' title="' + title + '"';
    }
    out += ">" + text + "</a>";
    return out;
  }
  image(href, title, text) {
    const cleanHref = cleanUrl(href);
    if (cleanHref === null) {
      return text;
    }
    href = cleanHref;
    let out = `<img src="${href}" alt="${text}"`;
    if (title) {
      out += ` title="${title}"`;
    }
    out += ">";
    return out;
  }
  text(text) {
    return text;
  }
};
var _TextRenderer = class {
  // no need for block level renderers
  strong(text) {
    return text;
  }
  em(text) {
    return text;
  }
  codespan(text) {
    return text;
  }
  del(text) {
    return text;
  }
  html(text) {
    return text;
  }
  text(text) {
    return text;
  }
  link(href, title, text) {
    return "" + text;
  }
  image(href, title, text) {
    return "" + text;
  }
  br() {
    return "";
  }
};
var _Parser = class __Parser {
  options;
  renderer;
  textRenderer;
  constructor(options2) {
    this.options = options2 || _defaults;
    this.options.renderer = this.options.renderer || new _Renderer();
    this.renderer = this.options.renderer;
    this.renderer.options = this.options;
    this.textRenderer = new _TextRenderer();
  }
  /**
   * Static Parse Method
   */
  static parse(tokens, options2) {
    const parser2 = new __Parser(options2);
    return parser2.parse(tokens);
  }
  /**
   * Static Parse Inline Method
   */
  static parseInline(tokens, options2) {
    const parser2 = new __Parser(options2);
    return parser2.parseInline(tokens);
  }
  /**
   * Parse Loop
   */
  parse(tokens, top = true) {
    let out = "";
    for (let i = 0; i < tokens.length; i++) {
      const token = tokens[i];
      if (this.options.extensions && this.options.extensions.renderers && this.options.extensions.renderers[token.type]) {
        const genericToken = token;
        const ret = this.options.extensions.renderers[genericToken.type].call({ parser: this }, genericToken);
        if (ret !== false || !["space", "hr", "heading", "code", "table", "blockquote", "list", "html", "paragraph", "text"].includes(genericToken.type)) {
          out += ret || "";
          continue;
        }
      }
      switch (token.type) {
        case "space": {
          continue;
        }
        case "hr": {
          out += this.renderer.hr();
          continue;
        }
        case "heading": {
          const headingToken = token;
          out += this.renderer.heading(this.parseInline(headingToken.tokens), headingToken.depth, unescape(this.parseInline(headingToken.tokens, this.textRenderer)));
          continue;
        }
        case "code": {
          const codeToken = token;
          out += this.renderer.code(codeToken.text, codeToken.lang, !!codeToken.escaped);
          continue;
        }
        case "table": {
          const tableToken = token;
          let header = "";
          let cell = "";
          for (let j = 0; j < tableToken.header.length; j++) {
            cell += this.renderer.tablecell(this.parseInline(tableToken.header[j].tokens), { header: true, align: tableToken.align[j] });
          }
          header += this.renderer.tablerow(cell);
          let body = "";
          for (let j = 0; j < tableToken.rows.length; j++) {
            const row = tableToken.rows[j];
            cell = "";
            for (let k = 0; k < row.length; k++) {
              cell += this.renderer.tablecell(this.parseInline(row[k].tokens), { header: false, align: tableToken.align[k] });
            }
            body += this.renderer.tablerow(cell);
          }
          out += this.renderer.table(header, body);
          continue;
        }
        case "blockquote": {
          const blockquoteToken = token;
          const body = this.parse(blockquoteToken.tokens);
          out += this.renderer.blockquote(body);
          continue;
        }
        case "list": {
          const listToken = token;
          const ordered = listToken.ordered;
          const start = listToken.start;
          const loose = listToken.loose;
          let body = "";
          for (let j = 0; j < listToken.items.length; j++) {
            const item = listToken.items[j];
            const checked = item.checked;
            const task = item.task;
            let itemBody = "";
            if (item.task) {
              const checkbox = this.renderer.checkbox(!!checked);
              if (loose) {
                if (item.tokens.length > 0 && item.tokens[0].type === "paragraph") {
                  item.tokens[0].text = checkbox + " " + item.tokens[0].text;
                  if (item.tokens[0].tokens && item.tokens[0].tokens.length > 0 && item.tokens[0].tokens[0].type === "text") {
                    item.tokens[0].tokens[0].text = checkbox + " " + item.tokens[0].tokens[0].text;
                  }
                } else {
                  item.tokens.unshift({
                    type: "text",
                    text: checkbox + " "
                  });
                }
              } else {
                itemBody += checkbox + " ";
              }
            }
            itemBody += this.parse(item.tokens, loose);
            body += this.renderer.listitem(itemBody, task, !!checked);
          }
          out += this.renderer.list(body, ordered, start);
          continue;
        }
        case "html": {
          const htmlToken = token;
          out += this.renderer.html(htmlToken.text, htmlToken.block);
          continue;
        }
        case "paragraph": {
          const paragraphToken = token;
          out += this.renderer.paragraph(this.parseInline(paragraphToken.tokens));
          continue;
        }
        case "text": {
          let textToken = token;
          let body = textToken.tokens ? this.parseInline(textToken.tokens) : textToken.text;
          while (i + 1 < tokens.length && tokens[i + 1].type === "text") {
            textToken = tokens[++i];
            body += "\n" + (textToken.tokens ? this.parseInline(textToken.tokens) : textToken.text);
          }
          out += top ? this.renderer.paragraph(body) : body;
          continue;
        }
        default: {
          const errMsg = 'Token with "' + token.type + '" type was not found.';
          if (this.options.silent) {
            console.error(errMsg);
            return "";
          } else {
            throw new Error(errMsg);
          }
        }
      }
    }
    return out;
  }
  /**
   * Parse Inline Tokens
   */
  parseInline(tokens, renderer) {
    renderer = renderer || this.renderer;
    let out = "";
    for (let i = 0; i < tokens.length; i++) {
      const token = tokens[i];
      if (this.options.extensions && this.options.extensions.renderers && this.options.extensions.renderers[token.type]) {
        const ret = this.options.extensions.renderers[token.type].call({ parser: this }, token);
        if (ret !== false || !["escape", "html", "link", "image", "strong", "em", "codespan", "br", "del", "text"].includes(token.type)) {
          out += ret || "";
          continue;
        }
      }
      switch (token.type) {
        case "escape": {
          const escapeToken = token;
          out += renderer.text(escapeToken.text);
          break;
        }
        case "html": {
          const tagToken = token;
          out += renderer.html(tagToken.text);
          break;
        }
        case "link": {
          const linkToken = token;
          out += renderer.link(linkToken.href, linkToken.title, this.parseInline(linkToken.tokens, renderer));
          break;
        }
        case "image": {
          const imageToken = token;
          out += renderer.image(imageToken.href, imageToken.title, imageToken.text);
          break;
        }
        case "strong": {
          const strongToken = token;
          out += renderer.strong(this.parseInline(strongToken.tokens, renderer));
          break;
        }
        case "em": {
          const emToken = token;
          out += renderer.em(this.parseInline(emToken.tokens, renderer));
          break;
        }
        case "codespan": {
          const codespanToken = token;
          out += renderer.codespan(codespanToken.text);
          break;
        }
        case "br": {
          out += renderer.br();
          break;
        }
        case "del": {
          const delToken = token;
          out += renderer.del(this.parseInline(delToken.tokens, renderer));
          break;
        }
        case "text": {
          const textToken = token;
          out += renderer.text(textToken.text);
          break;
        }
        default: {
          const errMsg = 'Token with "' + token.type + '" type was not found.';
          if (this.options.silent) {
            console.error(errMsg);
            return "";
          } else {
            throw new Error(errMsg);
          }
        }
      }
    }
    return out;
  }
};
var _Hooks = class {
  options;
  constructor(options2) {
    this.options = options2 || _defaults;
  }
  static passThroughHooks = /* @__PURE__ */ new Set([
    "preprocess",
    "postprocess",
    "processAllTokens"
  ]);
  /**
   * Process markdown before marked
   */
  preprocess(markdown) {
    return markdown;
  }
  /**
   * Process HTML after marked is finished
   */
  postprocess(html2) {
    return html2;
  }
  /**
   * Process all tokens before walk tokens
   */
  processAllTokens(tokens) {
    return tokens;
  }
};
var Marked = class {
  defaults = _getDefaults();
  options = this.setOptions;
  parse = this.#parseMarkdown(_Lexer.lex, _Parser.parse);
  parseInline = this.#parseMarkdown(_Lexer.lexInline, _Parser.parseInline);
  Parser = _Parser;
  Renderer = _Renderer;
  TextRenderer = _TextRenderer;
  Lexer = _Lexer;
  Tokenizer = _Tokenizer;
  Hooks = _Hooks;
  constructor(...args) {
    this.use(...args);
  }
  /**
   * Run callback for every token
   */
  walkTokens(tokens, callback) {
    let values = [];
    for (const token of tokens) {
      values = values.concat(callback.call(this, token));
      switch (token.type) {
        case "table": {
          const tableToken = token;
          for (const cell of tableToken.header) {
            values = values.concat(this.walkTokens(cell.tokens, callback));
          }
          for (const row of tableToken.rows) {
            for (const cell of row) {
              values = values.concat(this.walkTokens(cell.tokens, callback));
            }
          }
          break;
        }
        case "list": {
          const listToken = token;
          values = values.concat(this.walkTokens(listToken.items, callback));
          break;
        }
        default: {
          const genericToken = token;
          if (this.defaults.extensions?.childTokens?.[genericToken.type]) {
            this.defaults.extensions.childTokens[genericToken.type].forEach((childTokens) => {
              const tokens2 = genericToken[childTokens].flat(Infinity);
              values = values.concat(this.walkTokens(tokens2, callback));
            });
          } else if (genericToken.tokens) {
            values = values.concat(this.walkTokens(genericToken.tokens, callback));
          }
        }
      }
    }
    return values;
  }
  use(...args) {
    const extensions = this.defaults.extensions || { renderers: {}, childTokens: {} };
    args.forEach((pack) => {
      const opts = { ...pack };
      opts.async = this.defaults.async || opts.async || false;
      if (pack.extensions) {
        pack.extensions.forEach((ext) => {
          if (!ext.name) {
            throw new Error("extension name required");
          }
          if ("renderer" in ext) {
            const prevRenderer = extensions.renderers[ext.name];
            if (prevRenderer) {
              extensions.renderers[ext.name] = function(...args2) {
                let ret = ext.renderer.apply(this, args2);
                if (ret === false) {
                  ret = prevRenderer.apply(this, args2);
                }
                return ret;
              };
            } else {
              extensions.renderers[ext.name] = ext.renderer;
            }
          }
          if ("tokenizer" in ext) {
            if (!ext.level || ext.level !== "block" && ext.level !== "inline") {
              throw new Error("extension level must be 'block' or 'inline'");
            }
            const extLevel = extensions[ext.level];
            if (extLevel) {
              extLevel.unshift(ext.tokenizer);
            } else {
              extensions[ext.level] = [ext.tokenizer];
            }
            if (ext.start) {
              if (ext.level === "block") {
                if (extensions.startBlock) {
                  extensions.startBlock.push(ext.start);
                } else {
                  extensions.startBlock = [ext.start];
                }
              } else if (ext.level === "inline") {
                if (extensions.startInline) {
                  extensions.startInline.push(ext.start);
                } else {
                  extensions.startInline = [ext.start];
                }
              }
            }
          }
          if ("childTokens" in ext && ext.childTokens) {
            extensions.childTokens[ext.name] = ext.childTokens;
          }
        });
        opts.extensions = extensions;
      }
      if (pack.renderer) {
        const renderer = this.defaults.renderer || new _Renderer(this.defaults);
        for (const prop in pack.renderer) {
          if (!(prop in renderer)) {
            throw new Error(`renderer '${prop}' does not exist`);
          }
          if (prop === "options") {
            continue;
          }
          const rendererProp = prop;
          const rendererFunc = pack.renderer[rendererProp];
          const prevRenderer = renderer[rendererProp];
          renderer[rendererProp] = (...args2) => {
            let ret = rendererFunc.apply(renderer, args2);
            if (ret === false) {
              ret = prevRenderer.apply(renderer, args2);
            }
            return ret || "";
          };
        }
        opts.renderer = renderer;
      }
      if (pack.tokenizer) {
        const tokenizer = this.defaults.tokenizer || new _Tokenizer(this.defaults);
        for (const prop in pack.tokenizer) {
          if (!(prop in tokenizer)) {
            throw new Error(`tokenizer '${prop}' does not exist`);
          }
          if (["options", "rules", "lexer"].includes(prop)) {
            continue;
          }
          const tokenizerProp = prop;
          const tokenizerFunc = pack.tokenizer[tokenizerProp];
          const prevTokenizer = tokenizer[tokenizerProp];
          tokenizer[tokenizerProp] = (...args2) => {
            let ret = tokenizerFunc.apply(tokenizer, args2);
            if (ret === false) {
              ret = prevTokenizer.apply(tokenizer, args2);
            }
            return ret;
          };
        }
        opts.tokenizer = tokenizer;
      }
      if (pack.hooks) {
        const hooks = this.defaults.hooks || new _Hooks();
        for (const prop in pack.hooks) {
          if (!(prop in hooks)) {
            throw new Error(`hook '${prop}' does not exist`);
          }
          if (prop === "options") {
            continue;
          }
          const hooksProp = prop;
          const hooksFunc = pack.hooks[hooksProp];
          const prevHook = hooks[hooksProp];
          if (_Hooks.passThroughHooks.has(prop)) {
            hooks[hooksProp] = (arg) => {
              if (this.defaults.async) {
                return Promise.resolve(hooksFunc.call(hooks, arg)).then((ret2) => {
                  return prevHook.call(hooks, ret2);
                });
              }
              const ret = hooksFunc.call(hooks, arg);
              return prevHook.call(hooks, ret);
            };
          } else {
            hooks[hooksProp] = (...args2) => {
              let ret = hooksFunc.apply(hooks, args2);
              if (ret === false) {
                ret = prevHook.apply(hooks, args2);
              }
              return ret;
            };
          }
        }
        opts.hooks = hooks;
      }
      if (pack.walkTokens) {
        const walkTokens2 = this.defaults.walkTokens;
        const packWalktokens = pack.walkTokens;
        opts.walkTokens = function(token) {
          let values = [];
          values.push(packWalktokens.call(this, token));
          if (walkTokens2) {
            values = values.concat(walkTokens2.call(this, token));
          }
          return values;
        };
      }
      this.defaults = { ...this.defaults, ...opts };
    });
    return this;
  }
  setOptions(opt) {
    this.defaults = { ...this.defaults, ...opt };
    return this;
  }
  lexer(src, options2) {
    return _Lexer.lex(src, options2 ?? this.defaults);
  }
  parser(tokens, options2) {
    return _Parser.parse(tokens, options2 ?? this.defaults);
  }
  #parseMarkdown(lexer2, parser2) {
    return (src, options2) => {
      const origOpt = { ...options2 };
      const opt = { ...this.defaults, ...origOpt };
      if (this.defaults.async === true && origOpt.async === false) {
        if (!opt.silent) {
          console.warn("marked(): The async option was set to true by an extension. The async: false option sent to parse will be ignored.");
        }
        opt.async = true;
      }
      const throwError = this.#onError(!!opt.silent, !!opt.async);
      if (typeof src === "undefined" || src === null) {
        return throwError(new Error("marked(): input parameter is undefined or null"));
      }
      if (typeof src !== "string") {
        return throwError(new Error("marked(): input parameter is of type " + Object.prototype.toString.call(src) + ", string expected"));
      }
      if (opt.hooks) {
        opt.hooks.options = opt;
      }
      if (opt.async) {
        return Promise.resolve(opt.hooks ? opt.hooks.preprocess(src) : src).then((src2) => lexer2(src2, opt)).then((tokens) => opt.hooks ? opt.hooks.processAllTokens(tokens) : tokens).then((tokens) => opt.walkTokens ? Promise.all(this.walkTokens(tokens, opt.walkTokens)).then(() => tokens) : tokens).then((tokens) => parser2(tokens, opt)).then((html2) => opt.hooks ? opt.hooks.postprocess(html2) : html2).catch(throwError);
      }
      try {
        if (opt.hooks) {
          src = opt.hooks.preprocess(src);
        }
        let tokens = lexer2(src, opt);
        if (opt.hooks) {
          tokens = opt.hooks.processAllTokens(tokens);
        }
        if (opt.walkTokens) {
          this.walkTokens(tokens, opt.walkTokens);
        }
        let html2 = parser2(tokens, opt);
        if (opt.hooks) {
          html2 = opt.hooks.postprocess(html2);
        }
        return html2;
      } catch (e) {
        return throwError(e);
      }
    };
  }
  #onError(silent, async) {
    return (e) => {
      e.message += "\nPlease report this to https://github.com/markedjs/marked.";
      if (silent) {
        const msg = "<p>An error occurred:</p><pre>" + escape$1(e.message + "", true) + "</pre>";
        if (async) {
          return Promise.resolve(msg);
        }
        return msg;
      }
      if (async) {
        return Promise.reject(e);
      }
      throw e;
    };
  }
};
var markedInstance = new Marked();
function marked(src, opt) {
  return markedInstance.parse(src, opt);
}
marked.options = marked.setOptions = function(options2) {
  markedInstance.setOptions(options2);
  marked.defaults = markedInstance.defaults;
  changeDefaults(marked.defaults);
  return marked;
};
marked.getDefaults = _getDefaults;
marked.defaults = _defaults;
marked.use = function(...args) {
  markedInstance.use(...args);
  marked.defaults = markedInstance.defaults;
  changeDefaults(marked.defaults);
  return marked;
};
marked.walkTokens = function(tokens, callback) {
  return markedInstance.walkTokens(tokens, callback);
};
marked.parseInline = markedInstance.parseInline;
marked.Parser = _Parser;
marked.parser = _Parser.parse;
marked.Renderer = _Renderer;
marked.TextRenderer = _TextRenderer;
marked.Lexer = _Lexer;
marked.lexer = _Lexer.lex;
marked.Tokenizer = _Tokenizer;
marked.Hooks = _Hooks;
marked.parse = marked;
var options = marked.options;
var setOptions = marked.setOptions;
var use = marked.use;
var walkTokens = marked.walkTokens;
var parseInline = marked.parseInline;
var parser = _Parser.parse;
var lexer = _Lexer.lex;

// package.nls.json
var package_nls_default = {
  "add.eventListener.breakpoint": "Toggle Event Listener Breakpoints",
  "add.xhr.breakpoint": "Add XHR/fetch Breakpoint",
  "breakpoint.xhr.contains": "Break when URL contains:",
  "breakpoint.xhr.any": "Any XHR/fetch",
  "edit.xhr.breakpoint": "Edit XHR/fetch Breakpoint",
  "attach.node.process": "Attach to Node Process",
  "base.cascadeTerminateToConfigurations.label": "A list of debug sessions which, when this debug session is terminated, will also be stopped.",
  "base.enableDWARF.label": "Toggles whether the debugger will try to read DWARF debug symbols from WebAssembly, which can be resource intensive. Requires the `ms-vscode.wasm-dwarf-debugging` extension to function.",
  "browser.address.description": "IP address or hostname the debugged browser is listening on.",
  "browser.attach.port.description": "Port to use to remote debugging the browser, given as `--remote-debugging-port` when launching the browser.",
  "browser.baseUrl.description": "Base URL to resolve paths baseUrl. baseURL is trimmed when mapping URLs to the files on disk. Defaults to the launch URL domain.",
  "browser.browserAttachLocation.description": "Forces the browser to attach in one location. In a remote workspace (through ssh or WSL, for example) this can be used to attach to a browser on the remote machine rather than locally.",
  "browser.browserLaunchLocation.description": "Forces the browser to be launched in one location. In a remote workspace (through ssh or WSL, for example) this can be used to open the browser on the remote machine rather than locally.",
  "browser.cleanUp.description": "What clean-up to do after the debugging session finishes. Close only the tab being debug, vs. close the whole browser.",
  "browser.cwd.description": "Optional working directory for the runtime executable.",
  "browser.disableNetworkCache.description": "Controls whether to skip the network cache for each request",
  "browser.env.description": "Optional dictionary of environment key/value pairs for the browser.",
  "browser.file.description": "A local html file to open in the browser",
  "browser.includeDefaultArgs.description": "Whether default browser launch arguments (to disable features that may make debugging harder) will be included in the launch.",
  "browser.includeLaunchArgs.description": "Advanced: whether any default launch/debugging arguments are set on the browser. The debugger will assume the browser will use pipe debugging such as that which is provided with `--remote-debugging-pipe`.",
  "browser.inspectUri.description": 'Format to use to rewrite the inspectUri: It\'s a template string that interpolates keys in `{curlyBraces}`. Available keys are:\n - `url.*` is the parsed address of the running application. For instance, `{url.port}`, `{url.hostname}`\n - `port` is the debug port that Chrome is listening on.\n - `browserInspectUri` is the inspector URI on the launched browser\n - `browserInspectUriPath` is the path part of the inspector URI on the launched browser (e.g.: "/devtools/browser/e9ec0098-306e-472a-8133-5e42488929c2").\n - `wsProtocol` is the hinted websocket protocol. This is set to `wss` if the original URL is `https`, or `ws` otherwise.\n',
  "browser.launch.port.description": 'Port for the browser to listen on. Defaults to "0", which will cause the browser to be debugged via pipes, which is generally more secure and should be chosen unless you need to attach to the browser from another tool.',
  "browser.pathMapping.description": "A mapping of URLs/paths to local folders, to resolve scripts in the Browser to scripts on disk",
  "browser.perScriptSourcemaps.description": `Whether scripts are loaded individually with unique sourcemaps containing the basename of the source file. This can be set to optimize sourcemap handling when dealing with lots of small scripts. If set to "auto", we'll detect known cases where this is appropriate.`,
  "browser.profileStartup.description": "If true, will start profiling soon as the process launches",
  "browser.restart": "Whether to reconnect if the browser connection is closed",
  "browser.revealPage": "Focus Tab",
  "browser.runtimeArgs.description": "Optional arguments passed to the runtime executable.",
  "browser.runtimeExecutable.description": "Either 'canary', 'stable', 'custom' or path to the browser executable. Custom means a custom wrapper, custom build or CHROME_PATH environment variable.",
  "browser.runtimeExecutable.edge.description": "Either 'canary', 'stable', 'dev', 'custom' or path to the browser executable. Custom means a custom wrapper, custom build or EDGE_PATH environment variable.",
  "browser.server.description": "Configures a web server to start up. Takes the same configuration as the 'node' launch task.",
  "browser.skipFiles.description": 'An array of file or folder names, or path globs, to skip when debugging. Star patterns and negations are allowed, for example, `["**/node_modules/**", "!**/node_modules/my-module/**"]`',
  "browser.smartStep.description": "Automatically step through unmapped lines in sourcemapped files. For example, code that TypeScript produces automatically when downcompiling async/await or other features.",
  "browser.sourceMapPathOverrides.description": "A set of mappings for rewriting the locations of source files from what the sourcemap says, to their locations on disk. See README for details.",
  "browser.sourceMapRenames.description": 'Whether to use the "names" mapping in sourcemaps. This requires requesting source content, which can be slow with certain debuggers.',
  "browser.sourceMaps.description": "Use JavaScript source maps (if they exist).",
  "browser.targetSelection": 'Whether to attach to all targets that match the URL filter ("automatic") or ask to pick one ("pick").',
  "browser.timeout.description": "Retry for this number of milliseconds to connect to the browser. Default is 10000 ms.",
  "browser.url.description": "Will search for a tab with this exact url and attach to it, if found",
  "browser.urlFilter.description": "Will search for a page with this url and attach to it, if found. Can have * wildcards.",
  "browser.userDataDir.description": "By default, the browser is launched with a separate user profile in a temp folder. Use this option to override it. Set to false to launch with your default user profile. A new browser can't be launched if an instance is already running from `userDataDir`.",
  "browser.vueComponentPaths": "A list of file glob patterns to find `*.vue` components. By default, searches the entire workspace. This needs to be specified due to extra lookups that Vue's sourcemaps require in Vue CLI 4. You can disable this special handling by setting this to an empty array.",
  "browser.webRoot.description": 'This specifies the workspace absolute path to the webserver root. Used to resolve paths like `/app.js` to files on disk. Shorthand for a pathMapping for "/"',
  "chrome.attach.description": "Attach to an instance of Chrome already in debug mode",
  "chrome.attach.label": "Chrome: Attach",
  "chrome.label": "Web App (Chrome)",
  "chrome.launch.description": "Launch Chrome to debug a URL",
  "chrome.launch.label": "Chrome: Launch",
  "commands.callersAdd.label": "Exclude Caller",
  "commands.callersAdd.paletteLabel": "Exclude caller from pausing in the current location",
  "commands.callersGoToCaller.label": "Go to caller location",
  "commands.callersGoToTarget.label": "Go to target location",
  "commands.callersRemove.label": "Remove excluded caller",
  "commands.callersRemoveAll.label": "Remove all excluded callers",
  "commands.disableSourceMapStepping.label": "Disable Source Mapped Stepping",
  "commands.enableSourceMapStepping.label": "Enable Source Mapped Stepping",
  "configuration.autoAttachMode.always": "Auto attach to every Node.js process launched in the terminal.",
  "configuration.autoAttachMode.disabled": "Auto attach is disabled and not shown in status bar.",
  "configuration.autoAttachMode.explicit": "Only auto attach when the `--inspect` is given.",
  "configuration.autoAttachMode.smart": "Auto attach when running scripts that aren't in a node_modules folder.",
  "configuration.autoAttachMode": "Configures which processes to automatically attach and debug when `#debug.node.autoAttach#` is on. A Node process launched with the `--inspect` flag will always be attached to, regardless of this setting.",
  "configuration.autoAttachSmartPatterns": 'Configures glob patterns for determining when to attach in "smart" `#debug.javascript.autoAttachFilter#` mode. `$KNOWN_TOOLS$` is replaced with a list of names of common test and code runners. [Read more on the VS Code docs](https://code.visualstudio.com/docs/nodejs/nodejs-debugging#_auto-attach-smart-patterns).',
  "configuration.automaticallyTunnelRemoteServer": "When debugging a remote web app, configures whether to automatically tunnel the remote server to your local machine.",
  "configuration.breakOnConditionalError": "Whether to stop when conditional breakpoints throw an error.",
  "configuration.debugByLinkOptions": 'Options used when debugging open links clicked from inside the JavaScript Debug Terminal. Can be set to "off" to disable this behavior, or "always" to enable debugging in all terminals.',
  "configuration.defaultRuntimeExecutables": "The default `runtimeExecutable` used for launch configurations, if unspecified. This can be used to config custom paths to Node.js or browser installations.",
  "configuration.npmScriptLensLocation": 'Where a "Run" and "Debug" code lens should be shown in your npm scripts. It may be on "all", scripts, on "top" of the script section, or "never".',
  "configuration.pickAndAttachOptions": "Default options used when debugging a process through the `Debug: Attach to Node.js Process` command",
  "configuration.resourceRequestOptions": 'Request options to use when loading resources, such as source maps, in the debugger. You may need to configure this if your sourcemaps require authentication or use a self-signed certificate, for instance. Options are used to create a request using the [`got`](https://github.com/sindresorhus/got) library.\n\nA common case to disable certificate verification can be done by passing `{ "https": { "rejectUnauthorized": false } }`.',
  "configuration.terminalOptions": "Default launch options for the JavaScript debug terminal and npm scripts.",
  "configuration.unmapMissingSources": "Configures whether sourcemapped file where the original file can't be read will automatically be unmapped. If this is false (default), a prompt is shown.",
  "configuration.enableNetworkView": "Enables the experimental network view for targets that support it.",
  "createDiagnostics.label": "Diagnose Breakpoint Problems",
  "customDescriptionGenerator.description": "Customize the textual description the debugger shows for objects (local variables, etc...). Samples:\n      1. this.toString() // will call toString to print all objects\n      2. this.customDescription ? this.customDescription() : defaultValue // Use customDescription method if available, if not return defaultValue\n      3. function (def) { return this.customDescription ? this.customDescription() : def } // Use customDescription method if available, if not return defaultValue\n      ",
  "customPropertiesGenerator.description": "Customize the properties shown for an object in the debugger (local variables, etc...). Samples:\n    1. { ...this, extraProperty: '12345' } // Add an extraProperty 12345 to all objects\n    2. this.customProperties ? this.customProperties() : this // Use customProperties method if available, if not use the properties in this (the default properties)\n    3. function () { return this.customProperties ? this.customProperties() : this } // Use customDescription method if available, if not return the default properties\n\n    Deprecated: This is a temporary implementation of this feature until we have time to implement it in the way described here: https://github.com/microsoft/vscode/issues/102181",
  "debug.npm.edit": "Edit package.json",
  "debug.npm.noScripts": "No npm scripts found in your package.json",
  "debug.npm.noWorkspaceFolder": "You need to open a workspace folder to debug npm scripts.",
  "debug.npm.parseError": "Could not read {0}: {1}",
  "debug.npm.script": "Debug npm Script",
  "debug.terminal.attach": "Attach to Node.js Terminal Process",
  "debug.terminal.label": "JavaScript Debug Terminal",
  "debug.terminal.program.description": "Command to run in the launched terminal. If not provided, the terminal will open without launching a program.",
  "debug.terminal.snippet.label": 'Run "npm start" in a debug terminal',
  "debug.terminal.toggleAuto": "Toggle Terminal Node.js Auto Attach",
  "debug.terminal.welcome": {
    message: "[JavaScript Debug Terminal](command:extension.js-debug.createDebuggerTerminal)\n\nYou can use the JavaScript Debug Terminal to debug Node.js processes run on the command line.",
    comment: ["{Locked='](command:extension.js-debug.createDebuggerTerminal)'}"]
  },
  "debug.terminal.welcomeWithLink": {
    message: "[JavaScript Debug Terminal](command:extension.js-debug.createDebuggerTerminal)\n\nYou can use the JavaScript Debug Terminal to debug Node.js processes run on the command line.\n\n[Debug URL](command:extension.js-debug.debugLink)",
    comment: [
      "{Locked='](command:extension.js-debug.createDebuggerTerminal)'}",
      "{Locked='](command:extension.js-debug.debugLink)'}"
    ]
  },
  "debug.unverifiedBreakpoints": {
    message: "Some of your breakpoints could not be set. If you're having an issue, you can [troubleshoot your launch configuration](command:extension.js-debug.createDiagnostics).",
    comment: ["{Locked='](command:extension.js-debug.createDiagnostics)'}"]
  },
  "debugLink.label": "Open Link",
  "edge.address.description": "When debugging webviews, the IP address or hostname the webview is listening on. Will be automatically discovered if not set.",
  "edge.attach.description": "Attach to an instance of Edge already in debug mode",
  "edge.attach.label": "Edge: Attach",
  "edge.label": "Web App (Edge)",
  "edge.launch.description": "Launch Edge to debug a URL",
  "edge.launch.label": "Edge: Launch",
  "edge.port.description": "When debugging webviews, the port the webview debugger is listening on. Will be automatically discovered if not set.",
  "edge.useWebView.attach.description": 'An object containing the `pipeName` of a debug pipe for a UWP hosted Webview2. This is the "MyTestSharedMemory" when creating the pipe "\\\\.\\pipe\\LOCAL\\MyTestSharedMemory"',
  "edge.useWebView.launch.description": "When 'true', the debugger will treat the runtime executable as a host application that contains a WebView allowing you to debug the WebView script content.",
  "enableContentValidation.description": "Toggles whether we verify the contents of files on disk match the ones loaded in the runtime. This is useful in a variety of scenarios and required in some, but can cause issues if you have server-side transformation of scripts, for example.",
  "errors.timeout": "{0}: timeout after {1}ms",
  "extension.description": "An extension for debugging Node.js programs and Chrome.",
  "extensionHost.label": "VS Code Extension Development",
  "extensionHost.launch.config.name": "Launch Extension",
  "extensionHost.launch.debugWebviews": "Configures whether we should try to attach to webviews in the launched VS Code instance. This will only work in desktop VS Code.",
  "extensionHost.launch.debugWebWorkerHost": "Configures whether we should try to attach to the web worker extension host.",
  "extensionHost.launch.env.description": "Environment variables passed to the extension host.",
  "extensionHost.launch.rendererDebugOptions": "Chrome launch options used when attaching to the renderer process, with `debugWebviews` or `debugWebWorkerHost`.",
  "extensionHost.launch.testConfiguration": "Path to a test configuration file for the [test CLI](https://code.visualstudio.com/api/working-with-extensions/testing-extension#quick-setup-the-test-cli).",
  "extensionHost.launch.testConfigurationLabel": "A single configuration to run from the file. If not specified, you may be asked to pick.",
  "extensionHost.launch.runtimeExecutable.description": "Absolute path to VS Code.",
  "extensionHost.launch.stopOnEntry.description": "Automatically stop the extension host after launch.",
  "extensionHost.snippet.launch.description": "Launch a VS Code extension in debug mode",
  "extensionHost.snippet.launch.label": "VS Code Extension Development",
  "getDiagnosticLogs.label": "Save Diagnostic JS Debug Logs",
  "longPredictionWarning.disable": "Don't show again",
  "longPredictionWarning.message": "It's taking a while to configure your breakpoints. You can speed this up by updating the 'outFiles' in your launch.json.",
  "longPredictionWarning.noFolder": "No workspace folder open.",
  "longPredictionWarning.open": "Open launch.json",
  "node.address.description": "TCP/IP address of process to be debugged. Default is 'localhost'.",
  "node.attach.attachExistingChildren.description": "Whether to attempt to attach to already-spawned child processes.",
  "node.attach.attachSpawnedProcesses.description": "Whether to set environment variables in the attached process to track spawned children.",
  "node.attach.config.name": "Attach",
  "node.attach.continueOnAttach": "If true, we'll automatically resume programs launched and waiting on `--inspect-brk`",
  "node.attach.processId.description": "ID of process to attach to.",
  "node.attach.restart.description": "Try to reconnect to the program if we lose connection. If set to `true`, we'll try once a second, forever. You can customize the interval and maximum number of attempts by specifying the `delay` and `maxAttempts` in an object instead.",
  "node.attachSimplePort.description": "If set, attaches to the process via the given port. This is generally no longer necessary for Node.js programs and loses the ability to debug child processes, but can be useful in more esoteric scenarios such as with Deno and Docker launches. If set to 0, a random port will be chosen and --inspect-brk added to the launch arguments automatically.",
  "node.console.title": "Node Debug Console",
  "node.disableOptimisticBPs.description": "Don't set breakpoints in any file until a sourcemap has been loaded for that file.",
  "node.enableTurboSourcemaps.description": "Configures whether to use a new, faster mechanism for sourcemap discovery",
  "node.killBehavior.description": "Configures how debug processes are killed when stopping the session. Can be:\n\n- forceful (default): forcefully tears down the process tree. Sends SIGKILL on posix, or `taskkill.exe /F` on Windows.\n- polite: gracefully tears down the process tree. It's possible that misbehaving processes continue to run after shutdown in this way. Sends SIGTERM on posix, or `taskkill.exe` with no `/F` (force) flag on Windows.\n- none: no termination will happen.",
  "browser.killBehavior.description": "Configures how browser processes are killed when stopping the session with `cleanUp: wholeBrowser`. Can be:\n\n- forceful (default): forcefully tears down the process tree. Sends SIGKILL on posix, or `taskkill.exe /F` on Windows.\n- polite: gracefully tears down the process tree. It's possible that misbehaving processes continue to run after shutdown in this way. Sends SIGTERM on posix, or `taskkill.exe` with no `/F` (force) flag on Windows.\n- none: no termination will happen.",
  "node.label": "Node.js",
  "node.launch.args.description": "Command line arguments passed to the program.\n\nCan be an array of strings or a single string. When the program is launched in a terminal, setting this property to a single string will result in the arguments not being escaped for the shell.",
  "node.launch.autoAttachChildProcesses.description": "Attach debugger to new child processes automatically.",
  "node.launch.config.name": "Launch",
  "node.launch.console.description": "Where to launch the debug target.",
  "node.launch.console.externalTerminal.description": "External terminal that can be configured via user settings",
  "node.launch.console.integratedTerminal.description": "VS Code's integrated terminal",
  "node.launch.console.internalConsole.description": "VS Code Debug Console (which doesn't support to read input from a program)",
  "node.launch.cwd.description": "Absolute path to the working directory of the program being debugged. If you've set localRoot then cwd will match that value otherwise it falls back to your workspaceFolder",
  "node.launch.env.description": "Environment variables passed to the program. The value `null` removes the variable from the environment.",
  "node.launch.envFile.description": "Absolute path to a file containing environment variable definitions.",
  "node.launch.logging.cdp": "Path to the log file for Chrome DevTools Protocol messages",
  "node.launch.logging.dap": "Path to the log file for Debug Adapter Protocol messages",
  "node.launch.logging": "Logging configuration",
  "node.launch.outputCapture.description": "From where to capture output messages: the default debug API if set to `console`, or stdout/stderr streams if set to `std`.",
  "node.launch.program.description": "Absolute path to the program. Generated value is guessed by looking at package.json and opened files. Edit this attribute.",
  "node.launch.restart.description": "Try to restart the program if it exits with a non-zero exit code.",
  "node.launch.runtimeArgs.description": "Optional arguments passed to the runtime executable.",
  "node.launch.runtimeExecutable.description": "Runtime to use. Either an absolute path or the name of a runtime available on the PATH. If omitted `node` is assumed.",
  "node.launch.runtimeSourcemapPausePatterns": "A list of patterns at which to manually insert entrypoint breakpoints. This can be useful to give the debugger an opportunity to set breakpoints when using sourcemaps that don't exist or can't be detected before launch, such as [with the Serverless framework](https://github.com/microsoft/vscode-js-debug/issues/492).",
  "node.launch.runtimeVersion.description": "Version of `node` runtime to use. Requires `nvm`.",
  "node.launch.useWSL.deprecation": "'useWSL' is deprecated and support for it will be dropped. Use the 'Remote - WSL' extension instead.",
  "node.launch.useWSL.description": "Use Windows Subsystem for Linux.",
  "node.localRoot.description": "Path to the local directory containing the program.",
  "node.pauseForSourceMap.description": "Whether to wait for source maps to load for each incoming script. This has a performance overhead, and might be safely disabled when running off of disk, so long as `rootPath` is not disabled.",
  "node.port.description": "Debug port to attach to. Default is 9229.",
  "node.processattach.config.name": "Attach to Process",
  "node.profileStartup.description": "If true, will start profiling as soon as the process launches",
  "node.remoteRoot.description": "Absolute path to the remote directory containing the program.",
  "node.resolveSourceMapLocations.description": 'A list of minimatch patterns for locations (folders and URLs) in which source maps can be used to resolve local files. This can be used to avoid incorrectly breaking in external source mapped code. Patterns can be prefixed with "!" to exclude them. May be set to an empty array or null to avoid restriction.',
  "node.showAsyncStacks.description": "Show the async calls that led to the current call stack.",
  "node.snippet.attach.description": "Attach to a running node program",
  "node.snippet.attach.label": "Node.js: Attach",
  "node.snippet.attachProcess.description": "Open process picker to select node process to attach to",
  "node.snippet.attachProcess.label": "Node.js: Attach to Process",
  "node.snippet.electron.description": "Debug the Electron main process",
  "node.snippet.electron.label": "Node.js: Electron Main",
  "node.snippet.gulp.description": "Debug gulp task (make sure to have a local gulp installed in your project)",
  "node.snippet.gulp.label": "Node.js: Gulp task",
  "node.snippet.launch.description": "Launch a node program in debug mode",
  "node.snippet.launch.label": "Node.js: Launch Program",
  "node.snippet.mocha.description": "Debug mocha tests",
  "node.snippet.mocha.label": "Node.js: Mocha Tests",
  "node.snippet.nodemon.description": "Use nodemon to relaunch a debug session on source changes",
  "node.snippet.nodemon.label": "Node.js: Nodemon Setup",
  "node.snippet.npm.description": "Launch a node program through an npm `debug` script",
  "node.snippet.npm.label": "Node.js: Launch via npm",
  "node.snippet.remoteattach.description": "Attach to the debug port of a remote node program",
  "node.snippet.remoteattach.label": "Node.js: Attach to Remote Program",
  "node.snippet.yo.description": "Debug yeoman generator (install by running `npm link` in project folder)",
  "node.snippet.yo.label": "Node.js: Yeoman generator",
  "node.sourceMapPathOverrides.description": "A set of mappings for rewriting the locations of source files from what the sourcemap says, to their locations on disk.",
  "node.sourceMaps.description": "Use JavaScript source maps (if they exist).",
  "node.stopOnEntry.description": "Automatically stop program after launch.",
  "node.timeout.description": "Retry for this number of milliseconds to connect to Node.js. Default is 10000 ms.",
  "node.versionHint.description": "Allows you to explicitly specify the Node version that's running, which can be used to disable or enable certain behaviors in cases where the automatic version detection does not work.",
  "node.websocket.address.description": "Exact websocket address to attach to. If unspecified, it will be discovered from the address and port.",
  "node.remote.host.header.description": "Explicit Host header to use when connecting to the websocket of inspector. If unspecified, the host header will be set to 'localhost'. This is useful when the inspector is running behind a proxy that only accept particular Host header.",
  "node.experimentalNetworking.description": "Enable experimental inspection in Node.js. When set to `auto` this is enabled for versions of Node.js that support it. It can be set to `on` or `off` to enable or disable it explicitly.",
  "openEdgeDevTools.label": "Open Browser Devtools",
  "outFiles.description": "If source maps are enabled, these glob patterns specify the generated JavaScript files. If a pattern starts with `!` the files are excluded. If not specified, the generated code is expected in the same directory as its source.",
  "pretty.print.script": "Pretty print for debugging",
  "profile.start": "Take Performance Profile",
  "profile.stop": "Stop Performance Profile",
  "remove.eventListener.breakpoint.all": "Remove All Event Listener Breakpoints",
  "remove.xhr.breakpoint.all": "Remove All XHR/fetch Breakpoints",
  "remove.xhr.breakpoint": "Remove XHR/fetch Breakpoint",
  "requestCDPProxy.label": "Request CDP Proxy for Debug Session",
  "skipFiles.description": "An array of glob patterns for files to skip when debugging. The pattern `<node_internals>/**` matches all internal Node.js modules.",
  "smartStep.description": "Automatically step through generated code that cannot be mapped back to the original source.",
  "start.with.stop.on.entry": "Start Debugging and Stop on Entry",
  "startWithStopOnEntry.label": "Start Debugging and Stop on Entry",
  "timeouts.generalDescription.markdown": "Timeouts for several debugger operations.",
  "timeouts.generalDescription": "Timeouts for several debugger operations.",
  "timeouts.hoverEvaluation.description": "Time until value evaluation for hovered symbols is aborted. If set to 0, hover evaluation does never time out.",
  "timeouts.sourceMaps.description": "Timeouts related to source maps operations.",
  "timeouts.sourceMaps.sourceMapCumulativePause.description": "Extra time in milliseconds allowed per session to be spent waiting for source-maps to be processed, after the minimum time (sourceMapMinPause) has been exhausted",
  "timeouts.sourceMaps.sourceMapMinPause.description": "Minimum time in milliseconds spent waiting for each source-map to be processed when a script is being parsed",
  "toggle.skipping.this.file": "Toggle Skipping this File",
  "trace.boolean.description": "Trace may be set to 'true' to write diagnostic logs to the disk.",
  "trace.description": "Configures what diagnostic output is produced.",
  "trace.logFile.description": "Configures where on disk logs are written.",
  "trace.stdio.description": "Whether to return trace data from the launched application or browser.",
  "workspaceTrust.description": "Trust is required to debug code in this workspace.",
  "commands.networkViewRequest.label": "View Request as cURL",
  "commands.networkOpenBody.label": "Open Response Body",
  "commands.networkOpenBodyInHexEditor.label": "Open Response Body in Hex Editor",
  "commands.networkReplayXHR.label": "Replay Request",
  "commands.networkCopyURI.label": "Copy Request URL",
  "commands.networkClear.label": "Clear Network Log"
};

// src/common/contributionUtils.ts
var preferredDebugTypes = /* @__PURE__ */ new Map([
  ["pwa-node" /* Node */, "node"],
  ["pwa-chrome" /* Chrome */, "chrome"],
  ["pwa-extensionHost" /* ExtensionHost */, "extensionHost"],
  ["pwa-msedge" /* Edge */, "msedge"]
]);
var getPreferredOrDebugType = (t) => preferredDebugTypes.get(t) || t;
var debugTypes = {
  ["pwa-extensionHost" /* ExtensionHost */]: null,
  ["node-terminal" /* Terminal */]: null,
  ["pwa-node" /* Node */]: null,
  ["pwa-chrome" /* Chrome */]: null,
  ["pwa-msedge" /* Edge */]: null
};
var commandsObj = {
  ["extension.js-debug.addCustomBreakpoints" /* ToggleCustomBreakpoints */]: null,
  ["extension.js-debug.addXHRBreakpoints" /* AddXHRBreakpoints */]: null,
  ["extension.js-debug.editXHRBreakpoints" /* EditXHRBreakpoint */]: null,
  ["extension.pwa-node-debug.attachNodeProcess" /* AttachProcess */]: null,
  ["extension.js-debug.clearAutoAttachVariables" /* AutoAttachClearVariables */]: null,
  ["extension.js-debug.setAutoAttachVariables" /* AutoAttachSetVariables */]: null,
  ["extension.js-debug.autoAttachToProcess" /* AutoAttachToProcess */]: null,
  ["extension.js-debug.createDebuggerTerminal" /* CreateDebuggerTerminal */]: null,
  ["extension.js-debug.createDiagnostics" /* CreateDiagnostics */]: null,
  ["extension.js-debug.getDiagnosticLogs" /* GetDiagnosticLogs */]: null,
  ["extension.js-debug.debugLink" /* DebugLink */]: null,
  ["extension.js-debug.npmScript" /* DebugNpmScript */]: null,
  ["extension.js-debug.pickNodeProcess" /* PickProcess */]: null,
  ["extension.js-debug.prettyPrint" /* PrettyPrint */]: null,
  ["extension.js-debug.removeXHRBreakpoint" /* RemoveXHRBreakpoints */]: null,
  ["extension.js-debug.removeAllCustomBreakpoints" /* RemoveAllCustomBreakpoints */]: null,
  ["extension.js-debug.revealPage" /* RevealPage */]: null,
  ["extension.js-debug.startProfile" /* StartProfile */]: null,
  ["extension.js-debug.stopProfile" /* StopProfile */]: null,
  ["extension.js-debug.toggleSkippingFile" /* ToggleSkipping */]: null,
  ["extension.node-debug.startWithStopOnEntry" /* StartWithStopOnEntry */]: null,
  ["extension.js-debug.requestCDPProxy" /* RequestCDPProxy */]: null,
  ["extension.js-debug.openEdgeDevTools" /* OpenEdgeDevTools */]: null,
  ["extension.js-debug.callers.add" /* CallersAdd */]: null,
  ["extension.js-debug.callers.goToCaller" /* CallersGoToCaller */]: null,
  ["extension.js-debug.callers.gotToTarget" /* CallersGoToTarget */]: null,
  ["extension.js-debug.callers.remove" /* CallersRemove */]: null,
  ["extension.js-debug.callers.removeAll" /* CallersRemoveAll */]: null,
  ["extension.js-debug.enableSourceMapStepping" /* EnableSourceMapStepping */]: null,
  ["extension.js-debug.disableSourceMapStepping" /* DisableSourceMapStepping */]: null,
  ["extension.js-debug.network.viewRequest" /* NetworkViewRequest */]: null,
  ["extension.js-debug.network.copyUri" /* NetworkCopyUri */]: null,
  ["extension.js-debug.network.openBody" /* NetworkOpenBody */]: null,
  ["extension.js-debug.network.openBodyInHex" /* NetworkOpenBodyHex */]: null,
  ["extension.js-debug.network.replayXHR" /* NetworkReplayXHR */]: null,
  ["extension.js-debug.network.clear" /* NetworkClear */]: null,
  ["extension.js-debug.completion.nodeTool" /* CompletionNodeTool */]: null
};
var allCommands = new Set(Object.keys(commandsObj));
var allDebugTypes = new Set(Object.keys(debugTypes));
var networkFilesystemScheme = "jsDebugNetworkFs";

// src/common/knownTools.ts
var knownTools = /* @__PURE__ */ new Set([
  // #region test runners
  "mocha",
  "jest",
  "jest-cli",
  "ava",
  "tape",
  "tap",
  // #endregion,
  // #region transpilers
  "ts-node",
  "babel-node"
  // #endregion,
]);
var knownToolToken = "$KNOWN_TOOLS$";
var knownToolGlob = `{${[...knownTools].join(",")}}`;

// src/common/node15Internal.ts
var nodeInternalsToken = "<node_internals>";

// src/common/objUtils.ts
function mapValues(obj, generator) {
  const next = {};
  for (const key of Object.keys(obj)) {
    const value = obj[key];
    next[key] = generator(value, key);
  }
  return next;
}
function sortKeys(obj, sortFn) {
  if (!obj || typeof obj !== "object" || obj instanceof Array) {
    return obj;
  }
  const next = {};
  for (const key of Object.keys(obj).sort(sortFn)) {
    next[key] = obj[key];
  }
  return next;
}
function walkObject(obj, visitor) {
  obj = visitor(obj);
  if (obj) {
    if (obj instanceof Array) {
      obj = obj.map((v) => walkObject(v, visitor));
    } else if (typeof obj === "object" && obj) {
      for (const key of Object.keys(obj)) {
        obj[key] = walkObject(obj[key], visitor);
      }
    }
  }
  return obj;
}
var unset = Symbol("unset");
var maxInt32 = 2 ** 31 - 1;

// src/configuration.ts
var AnyLaunchConfiguration = Symbol("AnyLaunchConfiguration");
var baseDefaults = {
  type: "",
  name: "",
  request: "",
  trace: false,
  outputCapture: "console" /* Console */,
  timeout: 1e4,
  timeouts: {},
  showAsyncStacks: true,
  skipFiles: [],
  smartStep: true,
  sourceMaps: true,
  sourceMapRenames: true,
  pauseForSourceMap: true,
  resolveSourceMapLocations: null,
  rootPath: "${workspaceFolder}",
  outFiles: ["${workspaceFolder}/**/*.(m|c|)js", "!**/node_modules/**"],
  sourceMapPathOverrides: defaultSourceMapPathOverrides("${workspaceFolder}"),
  enableContentValidation: true,
  cascadeTerminateToConfigurations: [],
  enableDWARF: true,
  // Should always be determined upstream;
  __workspaceFolder: "",
  __remoteFilePrefix: void 0,
  __breakOnConditionalError: false,
  customDescriptionGenerator: void 0,
  customPropertiesGenerator: void 0
};
var nodeBaseDefaults = {
  ...baseDefaults,
  cwd: "${workspaceFolder}",
  env: {},
  envFile: null,
  pauseForSourceMap: false,
  sourceMaps: true,
  localRoot: null,
  remoteRoot: null,
  resolveSourceMapLocations: ["**", "!**/node_modules/**"],
  autoAttachChildProcesses: true,
  runtimeSourcemapPausePatterns: [],
  skipFiles: [`${nodeInternalsToken}/**`]
};
var terminalBaseDefaults = {
  ...nodeBaseDefaults,
  showAsyncStacks: { onceBreakpointResolved: 16 },
  type: "node-terminal" /* Terminal */,
  request: "launch",
  name: "JavaScript Debug Terminal"
};
var delegateDefaults = {
  ...nodeBaseDefaults,
  type: "node-terminal" /* Terminal */,
  request: "attach",
  name: terminalBaseDefaults.name,
  showAsyncStacks: { onceBreakpointResolved: 16 },
  delegateId: -1
};
var extensionHostConfigDefaults = {
  ...nodeBaseDefaults,
  type: "pwa-extensionHost" /* ExtensionHost */,
  name: "Debug Extension",
  request: "launch",
  args: ["--extensionDevelopmentPath=${workspaceFolder}"],
  outFiles: ["${workspaceFolder}/out/**/*.js"],
  resolveSourceMapLocations: ["${workspaceFolder}/**", "!**/node_modules/**"],
  rendererDebugOptions: {},
  runtimeExecutable: "${execPath}",
  autoAttachChildProcesses: false,
  debugWebviews: false,
  debugWebWorkerHost: false,
  __sessionId: ""
};
var nodeLaunchConfigDefaults = {
  ...nodeBaseDefaults,
  type: "pwa-node" /* Node */,
  request: "launch",
  program: "",
  cwd: "${workspaceFolder}",
  stopOnEntry: false,
  console: "internalConsole",
  restart: false,
  args: [],
  runtimeExecutable: "node",
  runtimeVersion: "default",
  runtimeArgs: [],
  profileStartup: false,
  attachSimplePort: null,
  experimentalNetworking: "auto",
  killBehavior: "forceful" /* Forceful */
};
var chromeAttachConfigDefaults = {
  ...baseDefaults,
  type: "pwa-chrome" /* Chrome */,
  request: "attach",
  address: "localhost",
  port: 0,
  disableNetworkCache: true,
  pathMapping: {},
  url: null,
  restart: false,
  urlFilter: "",
  sourceMapPathOverrides: defaultSourceMapPathOverrides("${webRoot}"),
  webRoot: "${workspaceFolder}",
  server: null,
  browserAttachLocation: "workspace",
  targetSelection: "automatic",
  vueComponentPaths: ["${workspaceFolder}/**/*.vue", "!**/node_modules/**"],
  perScriptSourcemaps: "auto"
};
var edgeAttachConfigDefaults = {
  ...chromeAttachConfigDefaults,
  type: "pwa-msedge" /* Edge */,
  useWebView: false
};
var chromeLaunchConfigDefaults = {
  ...chromeAttachConfigDefaults,
  type: "pwa-chrome" /* Chrome */,
  request: "launch",
  cwd: null,
  file: null,
  env: {},
  urlFilter: "*",
  includeDefaultArgs: true,
  includeLaunchArgs: true,
  runtimeArgs: null,
  runtimeExecutable: "*",
  userDataDir: true,
  browserLaunchLocation: "workspace",
  profileStartup: false,
  cleanUp: "wholeBrowser",
  killBehavior: "forceful" /* Forceful */
};
var edgeLaunchConfigDefaults = {
  ...chromeLaunchConfigDefaults,
  type: "pwa-msedge" /* Edge */,
  useWebView: false
};
var nodeAttachConfigDefaults = {
  ...nodeBaseDefaults,
  type: "pwa-node" /* Node */,
  attachExistingChildren: true,
  address: "localhost",
  port: 9229,
  restart: false,
  request: "attach",
  continueOnAttach: false
};
function defaultSourceMapPathOverrides(webRoot) {
  return {
    "webpack:///./~/*": `${webRoot}/node_modules/*`,
    "webpack:////*": "/*",
    "webpack://@?:*/?:*/*": `${webRoot}/*`,
    "webpack://?:*/*": `${webRoot}/*`,
    "webpack:///([a-z]):/(.+)": "$1:/$2",
    "meteor://\u{1F4BB}app/*": `${webRoot}/*`,
    "turbopack://[project]/*": "${workspaceFolder}/*",
    "turbopack:///[project]/*": "${workspaceFolder}/*"
  };
}
var breakpointLanguages = [
  "javascript",
  "typescript",
  "typescriptreact",
  "javascriptreact",
  "fsharp",
  "html",
  "wat",
  // Common wasm languages:
  "c",
  "cpp",
  "rust",
  "zig"
];
var packageName = true ? "js-debug" : "js-debug";
var packagePublisher = true ? "ms-vscode" : "vscode-samples";
var isNightly = packageName.includes("nightly");
var extensionId = `${packagePublisher}.${packageName}`;

// src/build/generate-contributions.ts
var appInsightsKey = "0c6ae279ed8443289764825290e4f9e2-1a736e7c-1324-4338-be46-fc2a58ae4d14-7255";
var forSomeContextKeys = (types, contextKey, andExpr) => [...types].map((d) => `${contextKey} == ${d}` + (andExpr ? ` && ${andExpr}` : "")).join(" || ");
var forAnyDebugType = (contextKey, andExpr) => forSomeContextKeys(allDebugTypes, contextKey, andExpr);
var forBrowserDebugType = (contextKey, andExpr) => forSomeContextKeys(["pwa-chrome" /* Chrome */, "pwa-msedge" /* Edge */], contextKey, andExpr);
var forNodeDebugType = (contextKey, andExpr) => forSomeContextKeys(["pwa-node" /* Node */, "pwa-extensionHost" /* ExtensionHost */, "node"], contextKey, andExpr);
var refString = (str) => `%${str}%`;
var commonLanguages = ["javascript", "typescript", "javascriptreact", "typescriptreact"];
var browserLanguages = [...commonLanguages, "html", "css", "coffeescript", "handlebars", "vue"];
var baseConfigurationAttributes = {
  resolveSourceMapLocations: {
    type: ["array", "null"],
    description: refString("node.resolveSourceMapLocations.description"),
    default: null,
    items: {
      type: "string"
    }
  },
  outFiles: {
    type: ["array"],
    description: refString("outFiles.description"),
    default: [...baseDefaults.outFiles],
    items: {
      type: "string"
    },
    tags: ["setup" /* Setup */]
  },
  pauseForSourceMap: {
    type: "boolean",
    markdownDescription: refString("node.pauseForSourceMap.description"),
    default: false
  },
  showAsyncStacks: {
    description: refString("node.showAsyncStacks.description"),
    default: true,
    oneOf: [
      {
        type: "boolean"
      },
      {
        type: "object",
        required: ["onAttach"],
        properties: {
          onAttach: {
            type: "number",
            default: 32
          }
        }
      },
      {
        type: "object",
        required: ["onceBreakpointResolved"],
        properties: {
          onceBreakpointResolved: {
            type: "number",
            default: 32
          }
        }
      }
    ]
  },
  skipFiles: {
    type: "array",
    description: refString("browser.skipFiles.description"),
    default: ["${/**"]
  },
  smartStep: {
    type: "boolean",
    description: refString("smartStep.description"),
    default: true
  },
  sourceMaps: {
    type: "boolean",
    description: refString("browser.sourceMaps.description"),
    default: true
  },
  sourceMapRenames: {
    type: "boolean",
    default: true,
    description: refString("browser.sourceMapRenames.description")
  },
  sourceMapPathOverrides: {
    type: "object",
    description: refString("node.sourceMapPathOverrides.description"),
    default: {
      "webpack://?:*/*": "${workspaceFolder}/*",
      "webpack:///./~/*": "${workspaceFolder}/node_modules/*",
      "meteor://\u{1F4BB}app/*": "${workspaceFolder}/*"
    }
  },
  timeout: {
    type: "number",
    description: refString("node.timeout.description"),
    default: 1e4
  },
  timeouts: {
    type: "object",
    description: refString("timeouts.generalDescription"),
    default: {},
    properties: {
      sourceMapMinPause: {
        type: "number",
        description: refString("timeouts.sourceMaps.sourceMapMinPause.description"),
        default: 1e3
      },
      sourceMapCumulativePause: {
        type: "number",
        description: refString("timeouts.sourceMaps.sourceMapCumulativePause.description"),
        default: 1e3
      },
      hoverEvaluation: {
        type: "number",
        description: refString("timeouts.hoverEvaluation.description"),
        default: 500
      }
    },
    additionalProperties: false,
    markdownDescription: refString("timeouts.generalDescription.markdown")
  },
  trace: {
    description: refString("trace.description"),
    default: true,
    oneOf: [
      {
        type: "boolean",
        description: refString("trace.boolean.description")
      },
      {
        type: "object",
        additionalProperties: false,
        properties: {
          stdio: {
            type: "boolean",
            description: refString("trace.stdio.description")
          },
          logFile: {
            type: ["string", "null"],
            description: refString("trace.logFile.description")
          }
        }
      }
    ]
  },
  outputCapture: {
    enum: ["console" /* Console */, "std" /* Stdio */],
    markdownDescription: refString("node.launch.outputCapture.description"),
    default: "console" /* Console */
  },
  enableContentValidation: {
    default: true,
    type: "boolean",
    description: refString("enableContentValidation.description")
  },
  customDescriptionGenerator: {
    type: "string",
    default: void 0,
    description: refString("customDescriptionGenerator.description")
  },
  customPropertiesGenerator: {
    type: "string",
    default: void 0,
    deprecated: true,
    description: refString("customPropertiesGenerator.description")
  },
  cascadeTerminateToConfigurations: {
    type: "array",
    items: {
      type: "string",
      uniqueItems: true
    },
    default: [],
    description: refString("base.cascadeTerminateToConfigurations.label")
  },
  enableDWARF: {
    type: "boolean",
    default: true,
    markdownDescription: refString("base.enableDWARF.label")
  }
};
var nodeBaseConfigurationAttributes = {
  ...baseConfigurationAttributes,
  resolveSourceMapLocations: {
    ...baseConfigurationAttributes.resolveSourceMapLocations,
    default: ["${workspaceFolder}/**", "!**/node_modules/**"]
  },
  cwd: {
    type: "string",
    description: refString("node.launch.cwd.description"),
    default: "${workspaceFolder}",
    docDefault: "localRoot || ${workspaceFolder}",
    tags: ["setup" /* Setup */]
  },
  localRoot: {
    type: ["string", "null"],
    description: refString("node.localRoot.description"),
    default: null
  },
  remoteRoot: {
    type: ["string", "null"],
    description: refString("node.remoteRoot.description"),
    default: null
  },
  autoAttachChildProcesses: {
    type: "boolean",
    description: refString("node.launch.autoAttachChildProcesses.description"),
    default: true
  },
  env: {
    type: "object",
    additionalProperties: {
      type: ["string", "null"]
    },
    markdownDescription: refString("node.launch.env.description"),
    default: {},
    tags: ["setup" /* Setup */]
  },
  envFile: {
    type: "string",
    description: refString("node.launch.envFile.description"),
    default: "${workspaceFolder}/.env"
  },
  runtimeSourcemapPausePatterns: {
    type: "array",
    items: {
      type: "string"
    },
    markdownDescription: refString("node.launch.runtimeSourcemapPausePatterns"),
    default: []
  },
  nodeVersionHint: {
    type: "number",
    minimum: 8,
    description: refString("node.versionHint.description"),
    default: 12
  }
};
var intOrEvaluated = [
  {
    type: "integer"
  },
  {
    type: "string",
    pattern: "^\\${.*}$"
  }
];
var nodeAttachConfig = {
  type: "pwa-node" /* Node */,
  request: "attach",
  label: refString("node.label"),
  languages: commonLanguages,
  variables: {
    PickProcess: "extension.js-debug.pickNodeProcess" /* PickProcess */
  },
  configurationSnippets: [
    {
      label: refString("node.snippet.attach.label"),
      description: refString("node.snippet.attach.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "attach",
        name: "${1:Attach}",
        port: 9229,
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    },
    {
      label: refString("node.snippet.remoteattach.label"),
      description: refString("node.snippet.remoteattach.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "attach",
        name: "${1:Attach to Remote}",
        address: "${2:TCP/IP address of process to be debugged}",
        port: 9229,
        localRoot: '^"\\${workspaceFolder}"',
        remoteRoot: "${3:Absolute path to the remote directory containing the program}",
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    },
    {
      label: refString("node.snippet.attachProcess.label"),
      description: refString("node.snippet.attachProcess.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "attach",
        name: "${1:Attach by Process ID}",
        processId: '^"\\${command:PickProcess}"',
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    }
  ],
  configurationAttributes: {
    ...nodeBaseConfigurationAttributes,
    address: {
      type: "string",
      description: refString("node.address.description"),
      default: "localhost"
    },
    port: {
      description: refString("node.port.description"),
      default: 9229,
      oneOf: intOrEvaluated,
      tags: ["setup" /* Setup */]
    },
    websocketAddress: {
      type: "string",
      description: refString("node.websocket.address.description"),
      default: void 0
    },
    remoteHostHeader: {
      type: "string",
      description: refString("node.remote.host.header.description"),
      default: void 0
    },
    restart: {
      description: refString("node.attach.restart.description"),
      default: true,
      oneOf: [
        {
          type: "boolean"
        },
        {
          type: "object",
          properties: {
            delay: { type: "number", minimum: 0, default: 1e3 },
            maxAttempts: { type: "number", minimum: 0, default: 10 }
          }
        }
      ]
    },
    processId: {
      type: "string",
      description: refString("node.attach.processId.description"),
      default: "${command:PickProcess}"
    },
    attachExistingChildren: {
      type: "boolean",
      description: refString("node.attach.attachExistingChildren.description"),
      default: false
    },
    continueOnAttach: {
      type: "boolean",
      markdownDescription: refString("node.attach.continueOnAttach"),
      default: true
    }
  },
  defaults: nodeAttachConfigDefaults
};
var nodeLaunchConfig = {
  type: "pwa-node" /* Node */,
  request: "launch",
  label: refString("node.label"),
  languages: commonLanguages,
  variables: {
    PickProcess: "extension.js-debug.pickNodeProcess" /* PickProcess */
  },
  configurationSnippets: [
    {
      label: refString("node.snippet.launch.label"),
      description: refString("node.snippet.launch.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "launch",
        name: "${2:Launch Program}",
        program: '^"\\${workspaceFolder}/${1:app.js}"',
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    },
    {
      label: refString("node.snippet.npm.label"),
      markdownDescription: refString("node.snippet.npm.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "launch",
        name: "${1:Launch via NPM}",
        runtimeExecutable: "npm",
        runtimeArgs: ["run-script", "debug"],
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    },
    {
      label: refString("node.snippet.nodemon.label"),
      description: refString("node.snippet.nodemon.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "launch",
        name: "nodemon",
        runtimeExecutable: "nodemon",
        program: '^"\\${workspaceFolder}/${1:app.js}"',
        restart: true,
        console: "integratedTerminal",
        internalConsoleOptions: "neverOpen",
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    },
    {
      label: refString("node.snippet.mocha.label"),
      description: refString("node.snippet.mocha.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "launch",
        name: "Mocha Tests",
        program: '^"mocha"',
        args: [
          "-u",
          "tdd",
          "--timeout",
          "999999",
          "--colors",
          '^"\\${workspaceFolder}/${1:test}"'
        ],
        internalConsoleOptions: "openOnSessionStart",
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    },
    {
      label: refString("node.snippet.yo.label"),
      markdownDescription: refString("node.snippet.yo.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "launch",
        name: "Yeoman ${1:generator}",
        program: '^"\\${workspaceFolder}/node_modules/yo/lib/cli.js"',
        args: ["${1:generator}"],
        console: "integratedTerminal",
        internalConsoleOptions: "neverOpen",
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    },
    {
      label: refString("node.snippet.gulp.label"),
      description: refString("node.snippet.gulp.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "launch",
        name: "Gulp ${1:task}",
        program: '^"\\${workspaceFolder}/node_modules/gulp/bin/gulp.js"',
        args: ["${1:task}"],
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    },
    {
      label: refString("node.snippet.electron.label"),
      description: refString("node.snippet.electron.description"),
      body: {
        type: "pwa-node" /* Node */,
        request: "launch",
        name: "Electron Main",
        runtimeExecutable: '^"electron"',
        program: '^"\\${workspaceFolder}/main.js"',
        skipFiles: [`${nodeInternalsToken}/**`]
      }
    }
  ],
  configurationAttributes: {
    ...nodeBaseConfigurationAttributes,
    cwd: {
      type: "string",
      description: refString("node.launch.cwd.description"),
      default: "${workspaceFolder}",
      tags: ["setup" /* Setup */]
    },
    program: {
      type: "string",
      description: refString("node.launch.program.description"),
      default: "",
      tags: ["setup" /* Setup */]
    },
    stopOnEntry: {
      type: ["boolean", "string"],
      description: refString("node.stopOnEntry.description"),
      default: true
    },
    console: {
      type: "string",
      enum: ["internalConsole", "integratedTerminal", "externalTerminal"],
      enumDescriptions: [
        refString("node.launch.console.internalConsole.description"),
        refString("node.launch.console.integratedTerminal.description"),
        refString("node.launch.console.externalTerminal.description")
      ],
      description: refString("node.launch.console.description"),
      default: "internalConsole"
    },
    args: {
      type: ["array", "string"],
      description: refString("node.launch.args.description"),
      items: {
        type: "string"
      },
      default: [],
      tags: ["setup" /* Setup */]
    },
    restart: {
      description: refString("node.launch.restart.description"),
      ...nodeAttachConfig.configurationAttributes.restart
    },
    runtimeExecutable: {
      type: ["string", "null"],
      markdownDescription: refString("node.launch.runtimeExecutable.description"),
      default: "node"
    },
    runtimeVersion: {
      type: "string",
      markdownDescription: refString("node.launch.runtimeVersion.description"),
      default: "default"
    },
    runtimeArgs: {
      type: "array",
      description: refString("node.launch.runtimeArgs.description"),
      items: {
        type: "string"
      },
      default: [],
      tags: ["setup" /* Setup */]
    },
    profileStartup: {
      type: "boolean",
      description: refString("node.profileStartup.description"),
      default: true
    },
    attachSimplePort: {
      oneOf: intOrEvaluated,
      description: refString("node.attachSimplePort.description"),
      default: 9229
    },
    killBehavior: {
      type: "string",
      enum: ["forceful" /* Forceful */, "polite" /* Polite */, "none" /* None */],
      default: "forceful" /* Forceful */,
      markdownDescription: refString("node.killBehavior.description")
    },
    experimentalNetworking: {
      type: "string",
      default: "auto",
      description: refString("node.experimentalNetworking.description"),
      enum: ["auto", "on", "off"]
    }
  },
  defaults: nodeLaunchConfigDefaults
};
var nodeTerminalConfiguration = {
  type: "node-terminal" /* Terminal */,
  request: "launch",
  label: refString("debug.terminal.label"),
  languages: [],
  configurationSnippets: [
    {
      label: refString("debug.terminal.snippet.label"),
      description: refString("debug.terminal.snippet.label"),
      body: {
        type: "node-terminal" /* Terminal */,
        request: "launch",
        name: "Run npm start",
        command: "npm start"
      }
    }
  ],
  configurationAttributes: {
    ...nodeBaseConfigurationAttributes,
    command: {
      type: ["string", "null"],
      description: refString("debug.terminal.program.description"),
      default: "npm start",
      tags: ["setup" /* Setup */]
    }
  },
  defaults: terminalBaseDefaults
};
var chromiumBaseConfigurationAttributes = {
  ...baseConfigurationAttributes,
  disableNetworkCache: {
    type: "boolean",
    description: refString("browser.disableNetworkCache.description"),
    default: true
  },
  pathMapping: {
    type: "object",
    description: refString("browser.pathMapping.description"),
    default: {}
  },
  webRoot: {
    type: "string",
    description: refString("browser.webRoot.description"),
    default: "${workspaceFolder}",
    tags: ["setup" /* Setup */]
  },
  urlFilter: {
    type: "string",
    description: refString("browser.urlFilter.description"),
    default: ""
  },
  url: {
    type: "string",
    description: refString("browser.url.description"),
    default: "http://localhost:8080",
    tags: ["setup" /* Setup */]
  },
  inspectUri: {
    type: ["string", "null"],
    description: refString("browser.inspectUri.description"),
    default: null
  },
  vueComponentPaths: {
    type: "array",
    description: refString("browser.vueComponentPaths"),
    default: ["${workspaceFolder}/**/*.vue"]
  },
  server: {
    oneOf: [
      {
        type: "object",
        description: refString("browser.server.description"),
        additionalProperties: false,
        default: { program: "node my-server.js" },
        properties: nodeLaunchConfig.configurationAttributes
      },
      {
        type: "object",
        description: refString("debug.terminal.label"),
        additionalProperties: false,
        default: { program: "npm start" },
        properties: nodeTerminalConfiguration.configurationAttributes
      }
    ]
    // eslint-disable-next-line
  },
  perScriptSourcemaps: {
    type: "string",
    default: "auto",
    enum: ["yes", "no", "auto"],
    description: refString("browser.perScriptSourcemaps.description")
  }
};
var chromiumAttachConfigurationAttributes = {
  ...chromiumBaseConfigurationAttributes,
  address: {
    type: "string",
    description: refString("browser.address.description"),
    default: "localhost"
  },
  port: {
    oneOf: intOrEvaluated,
    description: refString("browser.attach.port.description"),
    default: 9229,
    tags: ["setup" /* Setup */]
  },
  restart: {
    type: "boolean",
    markdownDescription: refString("browser.restart"),
    default: false
  },
  targetSelection: {
    type: "string",
    markdownDescription: refString("browser.targetSelection"),
    enum: ["pick", "automatic"],
    default: "automatic"
  },
  browserAttachLocation: {
    description: refString("browser.browserAttachLocation.description"),
    default: null,
    oneOf: [
      {
        type: "null"
      },
      {
        type: "string",
        enum: ["ui", "workspace"]
      }
    ]
  }
};
var chromeLaunchConfig = {
  type: "pwa-chrome" /* Chrome */,
  request: "launch",
  label: refString("chrome.label"),
  languages: browserLanguages,
  configurationSnippets: [
    {
      label: refString("chrome.launch.label"),
      description: refString("chrome.launch.description"),
      body: {
        type: "pwa-chrome" /* Chrome */,
        request: "launch",
        name: "Launch Chrome",
        url: "http://localhost:8080",
        webRoot: '^"${2:\\${workspaceFolder\\}}"'
      }
    }
  ],
  configurationAttributes: {
    ...chromiumBaseConfigurationAttributes,
    port: {
      type: "number",
      description: refString("browser.launch.port.description"),
      default: 0
    },
    file: {
      type: "string",
      description: refString("browser.file.description"),
      default: "${workspaceFolder}/index.html",
      tags: ["setup" /* Setup */]
    },
    userDataDir: {
      type: ["string", "boolean"],
      description: refString("browser.userDataDir.description"),
      default: true
    },
    includeDefaultArgs: {
      type: "boolean",
      description: refString("browser.includeDefaultArgs.description"),
      default: true
    },
    includeLaunchArgs: {
      type: "boolean",
      description: refString("browser.includeLaunchArgs.description"),
      default: true
    },
    runtimeExecutable: {
      type: ["string", "null"],
      description: refString("browser.runtimeExecutable.description"),
      default: "stable"
    },
    runtimeArgs: {
      type: "array",
      description: refString("browser.runtimeArgs.description"),
      items: {
        type: "string"
      },
      default: []
    },
    env: {
      type: "object",
      description: refString("browser.env.description"),
      default: {}
    },
    cwd: {
      type: "string",
      description: refString("browser.cwd.description"),
      default: null
    },
    profileStartup: {
      type: "boolean",
      description: refString("browser.profileStartup.description"),
      default: true
    },
    cleanUp: {
      type: "string",
      enum: ["wholeBrowser", "onlyTab"],
      description: refString("browser.cleanUp.description"),
      default: "wholeBrowser"
    },
    killBehavior: {
      type: "string",
      enum: ["forceful" /* Forceful */, "polite" /* Polite */, "none" /* None */],
      default: "forceful" /* Forceful */,
      markdownDescription: refString("browser.killBehavior.description")
    },
    browserLaunchLocation: {
      description: refString("browser.browserLaunchLocation.description"),
      default: null,
      oneOf: [
        {
          type: "null"
        },
        {
          type: "string",
          enum: ["ui", "workspace"]
        }
      ]
    }
  },
  defaults: chromeLaunchConfigDefaults
};
var chromeAttachConfig = {
  type: "pwa-chrome" /* Chrome */,
  request: "attach",
  label: refString("chrome.label"),
  languages: browserLanguages,
  configurationSnippets: [
    {
      label: refString("chrome.attach.label"),
      description: refString("chrome.attach.description"),
      body: {
        type: "pwa-chrome" /* Chrome */,
        request: "attach",
        name: "Attach to Chrome",
        port: 9222,
        webRoot: '^"${2:\\${workspaceFolder\\}}"'
      }
    }
  ],
  configurationAttributes: chromiumAttachConfigurationAttributes,
  defaults: chromeAttachConfigDefaults
};
var extensionHostConfig = {
  type: "pwa-extensionHost" /* ExtensionHost */,
  request: "launch",
  label: refString("extensionHost.label"),
  languages: commonLanguages,
  required: [],
  configurationSnippets: [
    {
      label: refString("extensionHost.snippet.launch.label"),
      description: refString("extensionHost.snippet.launch.description"),
      body: {
        type: "pwa-extensionHost" /* ExtensionHost */,
        request: "launch",
        name: refString("extensionHost.launch.config.name"),
        args: ['^"--extensionDevelopmentPath=\\${workspaceFolder}"'],
        outFiles: ['^"\\${workspaceFolder}/out/**/*.js"'],
        preLaunchTask: "npm"
      }
    }
  ],
  configurationAttributes: {
    ...nodeBaseConfigurationAttributes,
    args: {
      type: "array",
      description: refString("node.launch.args.description"),
      items: {
        type: "string"
      },
      default: ["--extensionDevelopmentPath=${workspaceFolder}"],
      tags: ["setup" /* Setup */]
    },
    runtimeExecutable: {
      type: ["string", "null"],
      markdownDescription: refString("extensionHost.launch.runtimeExecutable.description"),
      default: "node"
    },
    debugWebviews: {
      markdownDescription: refString("extensionHost.launch.debugWebviews"),
      default: true,
      type: ["boolean"]
    },
    debugWebWorkerHost: {
      markdownDescription: refString("extensionHost.launch.debugWebWorkerHost"),
      default: true,
      type: ["boolean"]
    },
    rendererDebugOptions: {
      markdownDescription: refString("extensionHost.launch.rendererDebugOptions"),
      type: "object",
      default: {
        webRoot: "${workspaceFolder}"
      },
      properties: chromiumAttachConfigurationAttributes
    },
    testConfiguration: {
      markdownDescription: refString("extensionHost.launch.testConfiguration"),
      type: "string",
      default: "${workspaceFolder}/.vscode-test.js"
    },
    testConfigurationLabel: {
      markdownDescription: refString("extensionHost.launch.testConfigurationLabel"),
      type: "string",
      default: ""
    }
  },
  defaults: extensionHostConfigDefaults
};
var edgeLaunchConfig = {
  type: "pwa-msedge" /* Edge */,
  request: "launch",
  label: refString("edge.label"),
  languages: browserLanguages,
  configurationSnippets: [
    {
      label: refString("edge.launch.label"),
      description: refString("edge.launch.description"),
      body: {
        type: "pwa-msedge" /* Edge */,
        request: "launch",
        name: "Launch Edge",
        url: "http://localhost:8080",
        webRoot: '^"${2:\\${workspaceFolder\\}}"'
      }
    }
  ],
  configurationAttributes: {
    ...chromeLaunchConfig.configurationAttributes,
    runtimeExecutable: {
      type: ["string", "null"],
      description: refString("browser.runtimeExecutable.edge.description"),
      default: "stable"
    },
    useWebView: {
      type: "boolean",
      description: refString("edge.useWebView.launch.description"),
      default: false
    },
    address: {
      type: "string",
      description: refString("edge.address.description"),
      default: "localhost"
    },
    port: {
      type: "number",
      description: refString("edge.port.description"),
      default: 9229
    }
  },
  defaults: edgeLaunchConfigDefaults
};
var edgeAttachConfig = {
  type: "pwa-msedge" /* Edge */,
  request: "attach",
  label: refString("edge.label"),
  languages: browserLanguages,
  configurationSnippets: [
    {
      label: refString("edge.attach.label"),
      description: refString("edge.attach.description"),
      body: {
        type: "pwa-msedge" /* Edge */,
        request: "attach",
        name: "Attach to Edge",
        port: 9222,
        webRoot: '^"${2:\\${workspaceFolder\\}}"'
      }
    }
  ],
  configurationAttributes: {
    ...chromiumAttachConfigurationAttributes,
    useWebView: {
      type: "object",
      properties: { pipeName: { type: "string" } },
      description: refString("edge.useWebView.attach.description"),
      default: { pipeName: "MyPipeName" }
    }
  },
  defaults: edgeAttachConfigDefaults
};
var debuggers = [
  nodeAttachConfig,
  nodeLaunchConfig,
  nodeTerminalConfiguration,
  extensionHostConfig,
  chromeLaunchConfig,
  chromeAttachConfig,
  edgeLaunchConfig,
  edgeAttachConfig
];
function buildDebuggers() {
  const output = [];
  const ensureEntryForType = (type, d) => {
    let entry = output.find((o) => o.type === type);
    if (entry) {
      return entry;
    }
    const { request, configurationAttributes, required, defaults, ...rest } = d;
    entry = {
      ...rest,
      type,
      aiKey: appInsightsKey,
      configurationAttributes: {},
      configurationSnippets: [],
      strings: { unverifiedBreakpoints: refString("debug.unverifiedBreakpoints") }
    };
    output.push(entry);
    return entry;
  };
  for (const d of debuggers) {
    const preferred = preferredDebugTypes.get(d.type);
    const primary = ensureEntryForType(d.type, d);
    const entries = [primary];
    if (preferred) {
      const entry = ensureEntryForType(preferred, d);
      delete entry.languages;
      entries.unshift(entry);
      primary.deprecated = `Please use type ${preferred} instead`;
    }
    entries[0].configurationSnippets.push(...d.configurationSnippets);
    if (preferred) {
      for (const snippet of entries[0].configurationSnippets) {
        snippet.body.type = preferred;
      }
    }
    for (const entry of entries) {
      entry.configurationAttributes[d.request] = {
        required: d.required,
        properties: mapValues(
          d.configurationAttributes,
          ({ docDefault: _, ...attrs }) => attrs
        )
      };
    }
  }
  return walkObject(output, sortKeys);
}
var configurationSchema = {
  ["debug.javascript.codelens.npmScripts" /* NpmScriptLens */]: {
    enum: ["top", "all", "never"],
    default: "top",
    description: refString("configuration.npmScriptLensLocation")
  },
  ["debug.javascript.terminalOptions" /* TerminalDebugConfig */]: {
    type: "object",
    description: refString("configuration.terminalOptions"),
    default: {},
    properties: nodeTerminalConfiguration.configurationAttributes
  },
  ["debug.javascript.automaticallyTunnelRemoteServer" /* AutoServerTunnelOpen */]: {
    type: "boolean",
    description: refString("configuration.automaticallyTunnelRemoteServer"),
    default: true
  },
  ["debug.javascript.debugByLinkOptions" /* DebugByLinkOptions */]: {
    default: "on",
    description: refString("configuration.debugByLinkOptions"),
    oneOf: [
      {
        type: "string",
        enum: ["on", "off", "always"]
      },
      {
        type: "object",
        properties: {
          ...chromeLaunchConfig.configurationAttributes,
          enabled: {
            type: "string",
            enum: ["on", "off", "always"]
          }
        }
      }
    ]
  },
  ["debug.javascript.pickAndAttachOptions" /* PickAndAttachDebugOptions */]: {
    type: "object",
    default: {},
    markdownDescription: refString("configuration.pickAndAttachOptions"),
    properties: nodeAttachConfig.configurationAttributes
  },
  ["debug.javascript.autoAttachFilter" /* AutoAttachMode */]: {
    type: "string",
    default: "disabled" /* Disabled */,
    enum: [
      "always" /* Always */,
      "smart" /* Smart */,
      "onlyWithFlag" /* OnlyWithFlag */,
      "disabled" /* Disabled */
    ],
    enumDescriptions: [
      refString("configuration.autoAttachMode.always"),
      refString("configuration.autoAttachMode.smart"),
      refString("configuration.autoAttachMode.explicit"),
      refString("configuration.autoAttachMode.disabled")
    ],
    markdownDescription: refString("configuration.autoAttachMode")
  },
  ["debug.javascript.autoAttachSmartPattern" /* AutoAttachSmartPatterns */]: {
    type: "array",
    items: {
      type: "string"
    },
    default: ["${workspaceFolder}/**", "!**/node_modules/**", `**/${knownToolToken}/**`],
    markdownDescription: refString("configuration.autoAttachSmartPatterns")
  },
  ["debug.javascript.breakOnConditionalError" /* BreakOnConditionalError */]: {
    type: "boolean",
    default: false,
    markdownDescription: refString("configuration.breakOnConditionalError")
  },
  ["debug.javascript.unmapMissingSources" /* UnmapMissingSources */]: {
    type: "boolean",
    default: false,
    description: refString("configuration.unmapMissingSources")
  },
  ["debug.javascript.defaultRuntimeExecutable" /* DefaultRuntimeExecutables */]: {
    type: "object",
    default: {
      ["pwa-node" /* Node */]: "node"
    },
    markdownDescription: refString("configuration.defaultRuntimeExecutables"),
    properties: ["pwa-node" /* Node */, "pwa-chrome" /* Chrome */, "pwa-msedge" /* Edge */].reduce(
      (obj, type) => ({ ...obj, [type]: { type: "string" } }),
      {}
    )
  },
  ["debug.javascript.resourceRequestOptions" /* ResourceRequestOptions */]: {
    type: "object",
    default: {},
    markdownDescription: refString("configuration.resourceRequestOptions")
  },
  ["debug.javascript.enableNetworkView" /* EnableNetworkView */]: {
    type: "boolean",
    default: true,
    description: refString("configuration.enableNetworkView")
  }
};
var commands = [
  {
    command: "extension.js-debug.prettyPrint" /* PrettyPrint */,
    title: refString("pretty.print.script"),
    category: "Debug",
    icon: "$(json)"
  },
  {
    command: "extension.js-debug.toggleSkippingFile" /* ToggleSkipping */,
    title: refString("toggle.skipping.this.file"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.addCustomBreakpoints" /* ToggleCustomBreakpoints */,
    title: refString("add.eventListener.breakpoint"),
    icon: "$(add)"
  },
  {
    command: "extension.js-debug.removeAllCustomBreakpoints" /* RemoveAllCustomBreakpoints */,
    title: refString("remove.eventListener.breakpoint.all"),
    icon: "$(close-all)"
  },
  {
    command: "extension.js-debug.addXHRBreakpoints" /* AddXHRBreakpoints */,
    title: refString("add.xhr.breakpoint"),
    icon: "$(add)"
  },
  {
    command: "extension.js-debug.removeXHRBreakpoint" /* RemoveXHRBreakpoints */,
    title: refString("remove.xhr.breakpoint"),
    icon: "$(remove)"
  },
  {
    command: "extension.js-debug.editXHRBreakpoints" /* EditXHRBreakpoint */,
    title: refString("edit.xhr.breakpoint"),
    icon: "$(edit)"
  },
  {
    command: "extension.pwa-node-debug.attachNodeProcess" /* AttachProcess */,
    title: refString("attach.node.process"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.npmScript" /* DebugNpmScript */,
    title: refString("debug.npm.script"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.createDebuggerTerminal" /* CreateDebuggerTerminal */,
    title: refString("debug.terminal.label"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.startProfile" /* StartProfile */,
    title: refString("profile.start"),
    category: "Debug",
    icon: "$(record)"
  },
  {
    command: "extension.js-debug.stopProfile" /* StopProfile */,
    title: refString("profile.stop"),
    category: "Debug",
    icon: "resources/dark/stop-profiling.svg"
  },
  {
    command: "extension.js-debug.revealPage" /* RevealPage */,
    title: refString("browser.revealPage"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.debugLink" /* DebugLink */,
    title: refString("debugLink.label"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.createDiagnostics" /* CreateDiagnostics */,
    title: refString("createDiagnostics.label"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.getDiagnosticLogs" /* GetDiagnosticLogs */,
    title: refString("getDiagnosticLogs.label"),
    category: "Debug"
  },
  {
    command: "extension.node-debug.startWithStopOnEntry" /* StartWithStopOnEntry */,
    title: refString("startWithStopOnEntry.label"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.openEdgeDevTools" /* OpenEdgeDevTools */,
    title: refString("openEdgeDevTools.label"),
    icon: "$(inspect)",
    category: "Debug"
  },
  {
    command: "extension.js-debug.callers.add" /* CallersAdd */,
    title: refString("commands.callersAdd.label"),
    category: "Debug"
  },
  {
    command: "extension.js-debug.callers.remove" /* CallersRemove */,
    title: refString("commands.callersRemove.label"),
    icon: "$(close)"
  },
  {
    command: "extension.js-debug.callers.removeAll" /* CallersRemoveAll */,
    title: refString("commands.callersRemoveAll.label"),
    icon: "$(clear-all)"
  },
  {
    command: "extension.js-debug.callers.goToCaller" /* CallersGoToCaller */,
    title: refString("commands.callersGoToCaller.label"),
    icon: "$(call-outgoing)"
  },
  {
    command: "extension.js-debug.callers.gotToTarget" /* CallersGoToTarget */,
    title: refString("commands.callersGoToTarget.label"),
    icon: "$(call-incoming)"
  },
  {
    command: "extension.js-debug.enableSourceMapStepping" /* EnableSourceMapStepping */,
    title: refString("commands.enableSourceMapStepping.label"),
    icon: "$(compass-dot)"
  },
  {
    command: "extension.js-debug.disableSourceMapStepping" /* DisableSourceMapStepping */,
    title: refString("commands.disableSourceMapStepping.label"),
    icon: "$(compass)"
  },
  {
    command: "extension.js-debug.network.viewRequest" /* NetworkViewRequest */,
    title: refString("commands.networkViewRequest.label"),
    icon: "$(arrow-right)"
  },
  {
    command: "extension.js-debug.network.clear" /* NetworkClear */,
    title: refString("commands.networkClear.label"),
    icon: "$(clear-all)"
  },
  {
    command: "extension.js-debug.network.openBody" /* NetworkOpenBody */,
    title: refString("commands.networkOpenBody.label")
  },
  {
    command: "extension.js-debug.network.openBodyInHex" /* NetworkOpenBodyHex */,
    title: refString("commands.networkOpenBodyInHexEditor.label")
  },
  {
    command: "extension.js-debug.network.replayXHR" /* NetworkReplayXHR */,
    title: refString("commands.networkReplayXHR.label")
  },
  {
    command: "extension.js-debug.network.copyUri" /* NetworkCopyUri */,
    title: refString("commands.networkCopyURI.label")
  }
];
var menus = {
  commandPalette: [
    {
      command: "extension.js-debug.prettyPrint" /* PrettyPrint */,
      title: refString("pretty.print.script"),
      when: forAnyDebugType("debugType", "debugState == stopped")
    },
    {
      command: "extension.js-debug.startProfile" /* StartProfile */,
      title: refString("profile.start"),
      when: forAnyDebugType("debugType", "inDebugMode && !jsDebugIsProfiling")
    },
    {
      command: "extension.js-debug.stopProfile" /* StopProfile */,
      title: refString("profile.stop"),
      when: forAnyDebugType("debugType", "inDebugMode && jsDebugIsProfiling")
    },
    {
      command: "extension.js-debug.revealPage" /* RevealPage */,
      when: "false"
    },
    {
      command: "extension.js-debug.debugLink" /* DebugLink */,
      title: refString("debugLink.label"),
      when: "!isWeb"
    },
    {
      command: "extension.js-debug.createDiagnostics" /* CreateDiagnostics */,
      title: refString("createDiagnostics.label"),
      when: forAnyDebugType("debugType", "inDebugMode")
    },
    {
      command: "extension.js-debug.getDiagnosticLogs" /* GetDiagnosticLogs */,
      title: refString("getDiagnosticLogs.label"),
      when: forAnyDebugType("debugType", "inDebugMode")
    },
    {
      command: "extension.js-debug.openEdgeDevTools" /* OpenEdgeDevTools */,
      title: refString("openEdgeDevTools.label"),
      when: `debugType == ${"pwa-msedge" /* Edge */}`
    },
    {
      command: "extension.js-debug.callers.add" /* CallersAdd */,
      title: refString("commands.callersAdd.paletteLabel"),
      when: forAnyDebugType("debugType", 'debugState == "stopped"')
    },
    {
      command: "extension.js-debug.callers.goToCaller" /* CallersGoToCaller */,
      when: "false"
    },
    {
      command: "extension.js-debug.callers.gotToTarget" /* CallersGoToTarget */,
      when: "false"
    },
    {
      command: "extension.js-debug.network.copyUri" /* NetworkCopyUri */,
      when: "false"
    },
    {
      command: "extension.js-debug.network.openBody" /* NetworkOpenBody */,
      when: "false"
    },
    {
      command: "extension.js-debug.network.openBodyInHex" /* NetworkOpenBodyHex */,
      when: "false"
    },
    {
      command: "extension.js-debug.network.replayXHR" /* NetworkReplayXHR */,
      when: "false"
    },
    {
      command: "extension.js-debug.network.viewRequest" /* NetworkViewRequest */,
      when: "false"
    },
    {
      command: "extension.js-debug.network.clear" /* NetworkClear */,
      when: "false"
    },
    {
      command: "extension.js-debug.enableSourceMapStepping" /* EnableSourceMapStepping */,
      when: "jsDebugIsMapSteppingDisabled" /* IsMapSteppingDisabled */
    },
    {
      command: "extension.js-debug.disableSourceMapStepping" /* DisableSourceMapStepping */,
      when: `!${"jsDebugIsMapSteppingDisabled" /* IsMapSteppingDisabled */}`
    }
  ],
  "debug/callstack/context": [
    {
      command: "extension.js-debug.revealPage" /* RevealPage */,
      group: "navigation",
      when: forBrowserDebugType("debugType", `callStackItemType == 'session'`)
    },
    {
      command: "extension.js-debug.toggleSkippingFile" /* ToggleSkipping */,
      group: "navigation",
      when: forAnyDebugType("debugType", `callStackItemType == 'session'`)
    },
    {
      command: "extension.js-debug.startProfile" /* StartProfile */,
      group: "navigation",
      when: forAnyDebugType("debugType", `!jsDebugIsProfiling && callStackItemType == 'session'`)
    },
    {
      command: "extension.js-debug.stopProfile" /* StopProfile */,
      group: "navigation",
      when: forAnyDebugType("debugType", `jsDebugIsProfiling && callStackItemType == 'session'`)
    },
    {
      command: "extension.js-debug.startProfile" /* StartProfile */,
      group: "inline",
      when: forAnyDebugType("debugType", "!jsDebugIsProfiling")
    },
    {
      command: "extension.js-debug.stopProfile" /* StopProfile */,
      group: "inline",
      when: forAnyDebugType("debugType", "jsDebugIsProfiling")
    },
    {
      command: "extension.js-debug.callers.add" /* CallersAdd */,
      when: forAnyDebugType("debugType", `callStackItemType == 'stackFrame'`)
    }
  ],
  "debug/toolBar": [
    {
      command: "extension.js-debug.stopProfile" /* StopProfile */,
      when: forAnyDebugType("debugType", "jsDebugIsProfiling")
    },
    {
      command: "extension.js-debug.openEdgeDevTools" /* OpenEdgeDevTools */,
      when: `debugType == ${"pwa-msedge" /* Edge */}`
    },
    {
      command: "extension.js-debug.enableSourceMapStepping" /* EnableSourceMapStepping */,
      when: "jsDebugIsMapSteppingDisabled" /* IsMapSteppingDisabled */
    }
  ],
  "view/title": [
    {
      command: "extension.js-debug.addCustomBreakpoints" /* ToggleCustomBreakpoints */,
      when: `view == ${"jsBrowserBreakpoints" /* EventListenerBreakpoints */}`,
      group: "navigation"
    },
    {
      command: "extension.js-debug.removeAllCustomBreakpoints" /* RemoveAllCustomBreakpoints */,
      when: `view == ${"jsBrowserBreakpoints" /* EventListenerBreakpoints */}`,
      group: "navigation"
    },
    {
      command: "extension.js-debug.callers.removeAll" /* CallersRemoveAll */,
      group: "navigation",
      when: `view == ${"jsExcludedCallers" /* ExcludedCallers */}`
    },
    {
      command: "extension.js-debug.disableSourceMapStepping" /* DisableSourceMapStepping */,
      group: "navigation",
      when: forAnyDebugType(
        "debugType",
        `view == workbench.debug.callStackView && !${"jsDebugIsMapSteppingDisabled" /* IsMapSteppingDisabled */}`
      )
    },
    {
      command: "extension.js-debug.enableSourceMapStepping" /* EnableSourceMapStepping */,
      group: "navigation",
      when: forAnyDebugType(
        "debugType",
        `view == workbench.debug.callStackView && ${"jsDebugIsMapSteppingDisabled" /* IsMapSteppingDisabled */}`
      )
    },
    {
      command: "extension.js-debug.network.clear" /* NetworkClear */,
      group: "navigation",
      when: `view == ${"jsDebugNetworkTree" /* Network */}`
    }
  ],
  "view/item/context": [
    {
      command: "extension.js-debug.addXHRBreakpoints" /* AddXHRBreakpoints */,
      when: `view == ${"jsBrowserBreakpoints" /* EventListenerBreakpoints */} && viewItem == xhrBreakpoint`
    },
    {
      command: "extension.js-debug.editXHRBreakpoints" /* EditXHRBreakpoint */,
      when: `view == ${"jsBrowserBreakpoints" /* EventListenerBreakpoints */} && viewItem == xhrBreakpoint`,
      group: "inline"
    },
    {
      command: "extension.js-debug.editXHRBreakpoints" /* EditXHRBreakpoint */,
      when: `view == ${"jsBrowserBreakpoints" /* EventListenerBreakpoints */} && viewItem == xhrBreakpoint`
    },
    {
      command: "extension.js-debug.removeXHRBreakpoint" /* RemoveXHRBreakpoints */,
      when: `view == ${"jsBrowserBreakpoints" /* EventListenerBreakpoints */} && viewItem == xhrBreakpoint`,
      group: "inline"
    },
    {
      command: "extension.js-debug.removeXHRBreakpoint" /* RemoveXHRBreakpoints */,
      when: `view == ${"jsBrowserBreakpoints" /* EventListenerBreakpoints */} && viewItem == xhrBreakpoint`
    },
    {
      command: "extension.js-debug.addXHRBreakpoints" /* AddXHRBreakpoints */,
      when: `view == ${"jsBrowserBreakpoints" /* EventListenerBreakpoints */} && viewItem == xhrCategory`,
      group: "inline"
    },
    {
      command: "extension.js-debug.callers.goToCaller" /* CallersGoToCaller */,
      group: "inline",
      when: `view == ${"jsExcludedCallers" /* ExcludedCallers */}`
    },
    {
      command: "extension.js-debug.callers.gotToTarget" /* CallersGoToTarget */,
      group: "inline",
      when: `view == ${"jsExcludedCallers" /* ExcludedCallers */}`
    },
    {
      command: "extension.js-debug.callers.remove" /* CallersRemove */,
      group: "inline",
      when: `view == ${"jsExcludedCallers" /* ExcludedCallers */}`
    },
    {
      command: "extension.js-debug.network.viewRequest" /* NetworkViewRequest */,
      group: "inline@1",
      when: `view == ${"jsDebugNetworkTree" /* Network */}`
    },
    {
      command: "extension.js-debug.network.openBody" /* NetworkOpenBody */,
      group: "body@1",
      when: `view == ${"jsDebugNetworkTree" /* Network */}`
    },
    {
      command: "extension.js-debug.network.openBodyInHex" /* NetworkOpenBodyHex */,
      group: "body@2",
      when: `view == ${"jsDebugNetworkTree" /* Network */}`
    },
    {
      command: "extension.js-debug.network.copyUri" /* NetworkCopyUri */,
      group: "other@1",
      when: `view == ${"jsDebugNetworkTree" /* Network */}`
    },
    {
      command: "extension.js-debug.network.replayXHR" /* NetworkReplayXHR */,
      group: "other@2",
      when: `view == ${"jsDebugNetworkTree" /* Network */}`
    }
  ],
  "editor/title": [
    {
      command: "extension.js-debug.prettyPrint" /* PrettyPrint */,
      group: "navigation",
      when: "jsDebugCanPrettyPrint" /* CanPrettyPrint */
    }
  ]
};
var keybindings = [
  {
    command: "extension.node-debug.startWithStopOnEntry" /* StartWithStopOnEntry */,
    key: "F10",
    mac: "F10",
    when: forNodeDebugType("debugConfigurationType", "!inDebugMode")
  },
  {
    command: "extension.node-debug.startWithStopOnEntry" /* StartWithStopOnEntry */,
    key: "F11",
    mac: "F11",
    when: forNodeDebugType(
      "debugConfigurationType",
      "!inDebugMode && activeViewlet == workbench.view.debug"
    )
  }
];
var viewsWelcome = [
  {
    view: "debug",
    contents: refString("debug.terminal.welcomeWithLink"),
    when: forSomeContextKeys(commonLanguages, "debugStartLanguage", "!isWeb")
  },
  {
    view: "debug",
    contents: refString("debug.terminal.welcome"),
    when: forSomeContextKeys(commonLanguages, "debugStartLanguage", "isWeb")
  }
];
var views = {
  debug: [
    {
      id: "jsBrowserBreakpoints" /* EventListenerBreakpoints */,
      name: "Event Listener Breakpoints",
      when: forBrowserDebugType("debugType")
    },
    {
      id: "jsExcludedCallers" /* ExcludedCallers */,
      name: "Excluded Callers",
      when: forAnyDebugType("debugType", "jsDebugHasExcludedCallers")
    },
    {
      id: "jsDebugNetworkTree" /* Network */,
      name: "Network",
      when: "jsDebugNetworkAvailable" /* NetworkAvailable */
    }
  ]
};
var activationEvents = /* @__PURE__ */ new Set([
  "onDebugDynamicConfigurations",
  "onDebugInitialConfigurations",
  `onFileSystem:${networkFilesystemScheme}`,
  ...[...debuggers.map((dbg) => dbg.type), ...preferredDebugTypes.values()].map(
    (t) => `onDebugResolve:${t}`
  ),
  ...[...allCommands].map((cmd) => `onCommand:${cmd}`)
]);
for (const { command } of commands) {
  activationEvents.delete(`onCommand:${command}`);
}
if (require.main === module) {
  process.stdout.write(
    JSON.stringify({
      capabilities: {
        virtualWorkspaces: false,
        untrustedWorkspaces: {
          supported: "limited",
          description: refString("workspaceTrust.description")
        }
      },
      activationEvents: [...activationEvents],
      contributes: {
        menus,
        breakpoints: breakpointLanguages.map((language) => ({ language })),
        debuggers: buildDebuggers(),
        commands,
        keybindings,
        configuration: {
          title: "JavaScript Debugger",
          properties: configurationSchema
        },
        grammars: [
          {
            language: "wat",
            scopeName: "text.wat",
            path: "./src/ui/basic-wat.tmLanguage.json"
          }
        ],
        languages: [
          {
            id: "wat",
            extensions: [".wat", ".wasm"],
            aliases: ["WebAssembly Text Format"],
            firstLine: "^\\(module",
            mimetypes: ["text/wat"],
            configuration: "./src/ui/basic-wat.configuration.json"
          }
        ],
        terminal: {
          profiles: [
            {
              id: "extension.js-debug.debugTerminal",
              title: refString("debug.terminal.label"),
              icon: "$(debug)"
            }
          ]
        },
        views,
        viewsWelcome
      }
    })
  );
}

// src/build/documentReadme.ts
(async () => {
  let out = `# Options

`;
  for (const dbg of debuggers) {
    out += `### ${getPreferredOrDebugType(dbg.type)}: ${dbg.request}

`;
    out += `<details>`;
    const entries = Object.entries(dbg.configurationAttributes).sort(
      ([a], [b]) => a.localeCompare(b)
    );
    for (const [key, value] of entries) {
      const descriptionKeyRaw = "markdownDescription" in value ? value.markdownDescription : value.description;
      if (!descriptionKeyRaw) {
        continue;
      }
      const descriptionKey = descriptionKeyRaw.slice(1, -1);
      const description = package_nls_default[descriptionKey].replace(/\n/g, "<br>");
      if (!description) {
        continue;
      }
      const defaultValue = dbg.defaults[key];
      const docDefault = value.docDefault ?? JSON.stringify(defaultValue, null, 2) ?? "undefined";
      out += `<h4>${key}</h4>`;
      out += `${marked(description)}`;
      out += `<h5>Default value:</h4>`;
      out += `<pre><code>${docDefault}</pre></code>`;
    }
    out += `</details>

`;
  }
  await import_fs.promises.writeFile("OPTIONS.md", out);
  await (0, import_execa.default)("node_modules/.bin/dprint", ["fmt", "OPTIONS.md"]);
})().catch(console.error);
