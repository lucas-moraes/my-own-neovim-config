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

// src/build/wasmCustom.ts
var wasmCustom_exports = {};
__export(wasmCustom_exports, {
  default: () => wasmCustom_default
});
module.exports = __toCommonJS(wasmCustom_exports);
var wasmCustom_default = {
  version: {
    major: "1",
    minor: "0"
  },
  domains: [
    {
      domain: "DotnetDebugger",
      experimental: true,
      types: [
        {
          id: "SetDebuggerPropertyParams",
          type: "object",
          description: 'Arguments for "setDebuggerProperty" request. Properties are determined by debugger.'
        },
        {
          id: "EvaluationOptions",
          type: "object",
          description: "Options that will be used to evaluate or to get variables."
        },
        {
          id: "SetSymbolOptionsParams",
          type: "object",
          description: 'Arguments for "setSymbolOptions" request. Properties are determined by debugger.'
        }
      ],
      commands: [
        {
          name: "setDebuggerProperty",
          description: "Sets a debugger property.",
          parameters: [
            {
              name: "params",
              $ref: "SetDebuggerPropertyParams"
            }
          ]
        },
        {
          name: "setEvaluationOptions",
          description: "Set options for evaluation",
          parameters: [
            {
              name: "options",
              $ref: "EvaluationOptions"
            },
            {
              name: "type",
              type: "string"
            }
          ]
        },
        {
          name: "setSymbolOptions",
          description: "Sets options for locating symbols."
        }
      ],
      events: [
        {
          name: "reportBlazorDebugException",
          description: "Fired when the attached Blazor DotnetDebugger itself, not the blazor app being debugged, reports an exception.",
          parameters: [
            {
              name: "exceptionType",
              description: "Specifies the type of exception.",
              type: "string",
              enum: ["uncaughtException", "unhandledRejection"]
            },
            {
              name: "exception",
              description: "Location in Blazor DotnetDebugger logic that is reporting the exception.",
              type: "string",
              enum: ["unknown", "undefined"]
            }
          ]
        }
      ]
    }
  ]
};
