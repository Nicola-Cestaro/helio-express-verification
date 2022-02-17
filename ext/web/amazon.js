chrome.extension.onMessage.addListener(function(msg, sender, sendResponse) {
    console.log(msg);
   document.querySelectorAll("#counterinit")[0].innerHTML = msg.action.toString();
});

function addCartButton() {
    const el = document.createElement('button');
    el.style.zIndex = '99999';
    el.innerText = 'Comprar';
    el.style.fontSize = "20px";
    el.style.position = '-webkit-sticky';
    el.style.boxShadow = 'inset 0px 1px 0px 0px #1058cb';
    el.style.background = 'linear-gradient(to bottom, #2176ff 5%, #1058cb 100%)';
    el.style.webkitTransitionDuration = '0.4s';
    el.style.transitionDuration = '0.4s';
    el.style.border = '1px solid #1058cb';
    el.style.color = '#ffffff';
    el.style.fontFamily = 'Arial';
    el.style.marginBottom = "20px";
    el.style.padding = '6px 10px';
    el.style.textDecoration = 'none';
    el.style.textShadow = '0px 1px 0px #1058cb'
    el.style.bottom = '20px';
    el.style.right = '20px';
    el.style.borderRadius = '12px';
    el.id = "intiexp";
    el.onclick = addCartClick;

    const s = document.createElement("input");
    s.style.paddingRight = '10px';
    s.height = 30;
    s.src = chrome.extension.getURL("icons/minilogo.png");
    s.type = "image";

    const em = document.createElement('button');
    em.style.zIndex = '99999';
    em.innerHTML = '0';
    em.style.boxShadow = 'inset 0px 1px 0px 0px #189338';
    em.style.background = 'linear-gradient(to bottom, #189338 5%, #189338 100%)';
    em.style.webkitTransitionDuration = '0.4s';
    em.style.transitionDuration = '0.4s';
    em.style.border = '1px solid #189338';
    em.style.color = '#ffffff';
    em.style.fontFamily = 'Arial';
    em.style.padding = '6px 10px';
    em.style.textDecoration = 'none';
    em.style.textShadow = '0px 1px 0px #189338'
    em.style.bottom = '50px';
    em.style.right = '10px';
    em.style.borderRadius = '12px';
    em.id = 'counterinit';
    try{
        document.getElementById("rightCol").prepend(el);
    } catch (e) {
        document.getElementsByClassName("container_right")[0].prepend(el);
    }
    el.prepend(s);
    //el.appendChild(em);
}

async function addCartClick() {

    let valid = true;

    let title = document.querySelectorAll("#landingImage");
    let imgUrl;

    if(title[0] === undefined){
        //console.log("try other title");
        title = document.querySelectorAll("#root > div > div > div > div.container_vertical_middle > div.container_left > div > div > div > div > div.a-fixed-left-grid-col.mainImageCell.qa-image-block-main-image.a-col-right > a > img");
        if(title[0] === undefined){
            //console.log("try other title 2");
            title = document.querySelectorAll("#imgBlkFront"); /// BOOKS
            if(title[0] === undefined){
                //console.log("try other title 3");
                title = document.querySelectorAll("#a-autoid-1-announce > img"); /// WHEN CHANGING COLOR
                if(title[0] === undefined){
                    valid = false;
                    //console.log("try other title null");
                } else {
                    imgUrl = title[0].getAttribute("src");
                    title = document.querySelectorAll("#productTitle");
                    title = title[0].innerHTML;
                }
            } else {
                imgUrl = title[0].getAttribute("src");
                title = document.querySelectorAll("#productTitle");
                title = title[0].innerHTML;
            }
        } else {
            imgUrl = title[0].getAttribute("src");
            title = title[0].getAttribute("alt");
        }
    } else {
        imgUrl = title[0].getAttribute("src");
        title = title[0].getAttribute("alt");
    }
    let price = document.querySelectorAll("#corePrice_feature_div > div > span > span.a-offscreen");
    if(price[0] === undefined){
        price = document.querySelectorAll("#attach-base-product-price");
        //console.log("try other price");
        if(price[0] === undefined){
            price = document.querySelectorAll("#price_inside_buybox");
            //console.log("try other price 2");
            if(price[0] === undefined){
                price = document.querySelectorAll("#price");
                //console.log("try other price 3");
                if(price[0] === undefined){
                    price = document.querySelectorAll(".a-price-whole"); /// IPHONE PAGE
                    //console.log("try other price 4");
                    if(price[0] === undefined){
                        //console.log("try other price null");
                        valid = false;
                    }
                } else {
                    price = price[0].innerHTML;
                }
            } else {
                price = price[0].innerHTML;
            }
        } else {
            price = price[0].getAttribute("value");
        }
    } else {
        price = price[0].innerHTML;
    }
    let asin = document.querySelectorAll("#ASIN");
    if(asin[0] === undefined){
        //console.log("try other asin 1");
          asin = document.querySelectorAll("#ask-btf-container > div > div > div.a-row.a-spacing-small.a-spacing-top-base > span > span > span > span > span > span > div > form > input.askAsin");
        if(asin[0] === undefined){
            //console.log("try other asin 2");
            valid = false;
        }
    }


    let isPrime = false;
    if(valid){

        //console.log(title);
        //console.log(price);
        //console.log(asin[0].getAttribute("value"));
        //console.log(imgUrl);
        //console.log(window.location.href);

        let product = [{
            "title":title,
            "price":price.replace(/[^0-9.]/g, ''),
            "asin":asin[0].getAttribute("value"),
            "img":imgUrl,
            "website": "amazon.com",
            "url": window.location.href
        }]

        const s = document.createElement("input");
        s.style.paddingLeft = '10px';
        s.height = 30;
        s.src = chrome.extension.getURL("icons/check-circle.gif");
        s.type = "image";
        
        const button = document.getElementById("intiexp");
        button.innerText = "AÑADIDO";
        button.style.background = 'linear-gradient(to bottom, #2176ff 5%, #1058cb 100%)';
        button.style.position = '-webkit-sticky';
        button.style.boxShadow = 'inset 0px 1px 0px 0px #1058cb';
        button.style.webkitTransitionDuration = '0.4s';
        button.style.transitionDuration = '0.4s';
        button.style.border = '1px solid #1058cb';
        button.style.color = '#ffffff';
        button.style.fontFamily = 'Arial';
        button.style.padding = '6px 10px';
        button.style.textDecoration = 'none';
        button.style.textShadow = '0px 1px 0px #1058cb'
        button.style.bottom = '20px';
        button.style.right = '20px';
        button.style.borderRadius = '12px';
        button.appendChild(s);

        //console.log(product);
        var editorExtensionId = "lekmcdnkbmbaopllbmoinndcdkagaafg";

        chrome.runtime.sendMessage({message: "product",body: product},
            function(response) {
                if (!response.success){
                    //console.log(response);
                }
            });

    } else {
        const button = document.getElementById("intiexp");
        button.innerText = "INCAPAZ DE AÑADIR";
        button.style.background = 'linear-gradient(to bottom, #D31D1D 5%, #D31D1D 100%)';
        button.style.position = '-webkit-sticky';
        button.style.boxShadow = 'inset 0px 1px 0px 0px #D31D1D';
        button.style.webkitTransitionDuration = '0.4s';
        button.style.transitionDuration = '0.4s';
        button.style.border = '1px solid #D31D1D';
        button.style.color = '#ffffff';
        button.style.fontFamily = 'Arial';
        button.style.padding = '6px 10px';
        button.style.textDecoration = 'none';
        button.style.textShadow = '0px 1px 0px #D31D1D'
        button.style.bottom = '20px';
        button.style.right = '20px';
        button.style.borderRadius = '12px';
    }
}

function main() {
    addCartButton();
}

main();
