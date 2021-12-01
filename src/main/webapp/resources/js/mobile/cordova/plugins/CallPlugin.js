cordova.define("io.cordova.hellocordova.CallPlugin", function(require, exports, module) {

   var exec = require('cordova/exec');
   
   var CallPlugin = {
      CallPlugin : function(successCallback, errorCallback) {
         exec(successCallback, errorCallback, "CallPlugin", "CallPlugin", [""]);
      }
   };
   
   module.exports = CallPlugin;
});