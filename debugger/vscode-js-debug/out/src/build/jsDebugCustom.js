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

// src/build/jsDebugCustom.ts
var jsDebugCustom_exports = {};
__export(jsDebugCustom_exports, {
  default: () => jsDebugCustom_default
});
module.exports = __toCommonJS(jsDebugCustom_exports);
var jsDebugCustom_default = {
  version: {
    major: "1",
    minor: "0"
  },
  domains: [
    {
      domain: "JsDebug",
      experimental: true,
      commands: [
        {
          name: "subscribe",
          description: "Subscribes to the given CDP event(s). Events will not be sent through the\nconnection unless you subscribe to them",
          parameters: [
            {
              name: "events",
              description: "List of events to subscribe to. Supports wildcards, for example\nyou can subscribe to `Debugger.scriptParsed` or `Debugger.*`",
              type: "array",
              items: {
                type: "string"
              }
            }
          ]
        }
      ]
    }
  ]
};
