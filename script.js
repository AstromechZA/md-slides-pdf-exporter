const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    executablePath: '/usr/bin/chromium-browser',
    args: [
      "--no-sandbox",
    ],
  });
  const page = await browser.newPage();
  await page.goto('file:///source/index.html', {timeout: 3000});
  await page.pdf({
      path: '/output/index.pdf', 
      printBackground: true,
      preferCSSPageSize: true,
  });

  await browser.close();
})();
