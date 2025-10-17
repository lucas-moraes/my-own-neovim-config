"use strict";
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// src/build/generate-contributions.ts
var generate_contributions_exports = {};
__export(generate_contributions_exports, {
  debuggers: () => debuggers
});
module.exports = __toCommonJS(generate_contributions_exports);

// src/common/contributionUtils.ts
var preferredDebugTypes = /* @__PURE__ */ new Map([
  ["pwa-node" /* Node */, "node"],
  ["pwa-chrome" /* Chrome */, "chrome"],
  ["pwa-extensionHost" /* ExtensionHost */, "extensionHost"],
  ["pwa-msedge" /* Edge */, "msedge"]
]);
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
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  debuggers
});
