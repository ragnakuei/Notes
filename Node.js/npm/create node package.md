# create node package

### 範例

1. mkdir custom-node-package
   `custom-node-package` 就當作是 package name
1. npm init

1. 建立 index.js
   ```js
   class CustomNodePackage {
      run() {
         console.log('custom node pacakge !');
      }
   }

   module.exports = {
      customNodePackage: new CustomNodePackage(),
   }
   ```

1. npm link
1. mkdir tester
1. cd tester
1. npm init
1. npm link custom-node-package
1. 建立 app.js

   ```js
   const { customNodePackage } = require('custom-node-package');

   customNodePackage.run();
   ```

1. node app.js

