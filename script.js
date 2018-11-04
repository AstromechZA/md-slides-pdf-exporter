const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({'executablePath': '/usr/bin/chromium-browser'});
  const page = await browser.newPage();
  await page.goto('file:///source/index.html', {});
  await page.pdf({
      path: '/output/index.pdf', 
      printBackground: true,
      preferCSSPageSize: true,
  });

  await browser.close();
})();
