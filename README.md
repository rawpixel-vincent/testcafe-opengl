# testcafe opengl

Run testcafe on arm64 arch, add webgl v2 support to firefox / chrome **without the need for a GPU**

N.B. Provided as is for the community,
PR and feedback are welcome.

## Usage

### Run the image

This is an example, you probably want to fork this repo and adjust it to your needs.

```bash
cd docker
cp -r /path/to/your/tests tests
rm -rf tests/node_modules
docker build -t testcafe-opengl
docker run --init --env TESTCAFE_CMD="see below" --env XVFB_WHD=1920x1080x24 --volume=/optional:/tmp/for-your-test-results
```

### Examples of TESTCAFE_CMD

`TESTCAFE_CMD="node node_modules/testcafe/bin/testcafe-with-v8-flag-filter.js \"firefox\" testcafe/"`

`TESTCAFE_CMD="node node_modules/testcafe/bin/testcafe-with-v8-flag-filter.js \"chromium --use-gl=desktop --enable-webgl -gpu --gpu-launcher --in-process-gpu --ignore-gpu-blacklist --ignore-gpu-blocklist --no-sandbox --disable-dev-shm-usage --allow-insecure-localhost --ignore-certificate-errors --ignore-ssl-errors\" testcafe/"`

### Configuration file example

`tests/ssl.ci.testcaferc.js`:

```javascript
module.exports = {
  pageLoadTimeout: 30000,
  retryTestPages: true,
  cache: true,
  concurrency: 3,
  videoPath: '/tmp/test-results/videos',
  videoOptions: {
    failedOnly: true,
  },
  screenshots: {
    takeOnFails: true,
    path: '/tmp/test-results/screenshots',
  },
  reporter: [
    {
      name: 'spec',
    },
    {
      name: 'jenkins',
      output: '/tmp/test-results/report.xml',
    },
  ],
  hostname: 'localhost',
  ssl: {
    pfx: '/opt/testcafe-ssl-config/testingdomain.pfx',
    rejectUnauthorized: true,
  },
};

```

Run with
`TESTCAFE_CMD="node node_modules/testcafe/bin/testcafe-with-v8-flag-filter.js 'chromium --use-gl=desktop --enable-webgl -gpu --gpu-launcher --in-process-gpu --ignore-gpu-blacklist --ignore-gpu-blocklist --no-sandbox --disable-dev-shm-usage --allow-insecure-localhost --ignore-certificate-errors --ignore-ssl-errors\" testcafe/ --config-file ssl.ci.testcaferc.js"`

## Credits

**Credits to https://github.com/utensils/docker-opengl for the insights**
