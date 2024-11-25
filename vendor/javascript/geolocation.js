// geolocation@0.2.0 downloaded from https://ga.jspm.io/npm:geolocation@0.2.0/index.js

import t from"events";import e from"inherits";import n from"debug";import r from"process";var o="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var i={};var a=r;var c=t.EventEmitter,s=e,h=n("geolocation");var g,l=0,f,u=new c;u.setMaxListeners(0);i=i=u;i.options={};i.getCurrentPosition=function(t){if(l)if(g){h("get current location - cache hit");a.nextTick((function(){t(null,g)}))}else{h("get current location - cache fetching");function changeListener(e){u.removeListener("error",errorListener);t(null,e)}function errorListener(e){u.removeListener("change",changeListener);t(e)}u.once("change",changeListener);u.once("error",errorListener)}else{h("get current location - cache miss");navigator.geolocation.getCurrentPosition((function(e){t(null,e)}),(function(e){t(e)}),i.options)}};i.createWatcher=function(t){var e=new Watcher;t&&e.on("change",t);e.start();return e};function Watcher(){c.call(this||o);(this||o).watching=false;var t=this||o;(this||o).changeHandler=function(e){t.emit("change",e)}}s(Watcher,c);i.Watcher=Watcher;Watcher.prototype.start=function(){if(!(this||o).watching){(this||o).watching=true;l++;h("start watcher");u.on("change",(this||o).changeHandler);if(1===l){h("start geolocation watch position");f=navigator.geolocation.watchPosition((function(t){g=t;u.emit("change",t)}),(function(t){u.emit("error",t)}),(this||o).options)}}};Watcher.prototype.stop=function(){if((this||o).watching){(this||o).watching=false;l--;u.removeListener("change",(this||o).changeHandler);if(!l){h("clear geolocation watch");navigator.geolocation.clearWatch(f)}}};var p=i;const m=i.options,v=i.getCurrentPosition,W=i.createWatcher;const w=i.Watcher;export default p;export{w as Watcher,W as createWatcher,v as getCurrentPosition,m as options};
