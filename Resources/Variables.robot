*** Variables ***

${petshop}    //div//a[@id="header-categories--pet-shop-c-a0"]
${categories}    xpath=//span[text()='KATEGORİLER']
${accept_cookies}    xpath=//button[@id='accept-all']
${close_popover}    xpath=//div[@class='title-close-btn-wrapper']/fa-icon[@class='ng-fa-icon']
${menu}    .categories-wrapper
${sort}        //div[contains(@class, 'mat-mdc-select-trigger')]
${first_lowest_price}        //span[text()=' Önce En Düşük Fiyat ']
${first_item_name}        //sm-list-page-item[1]//a[@id='product-name']
${price_locator}        //fe-product-price[@id='price-no-discount']
${loading}        //div[@id='cdk-overlay-5']
${migros_url}   https://www.migros.com.tr/
${cookie_file}   ./Resources/cookies.json
${browser}    Chrome
