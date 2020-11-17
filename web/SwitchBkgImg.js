
var imgList=["Img1","Img2","Img3","Img4","Img5","Img6"];
var index1=0;
var index2=1;
var upperElement=document.getElementById("bkgImg1");
var lowerElement=document.getElementById("bkgImg2");

var timeFade = null;

function fadeOut(){
    timeFade = setInterval(function (){
        upperElement.style.opacity -= 0.01;
        if (upperElement.style.opacity <= 0){
            clearInterval(timeFade);
            index1++;
            if (index1 == 6){
                index1 = 0;
            }
            index2++;
            if (index2 == 6){
                index2 = 0;
            }
        }
    },10);
}

setInterval(function (){
    fadeOut();
    setTimeout(function (){upperElement.style.backgroundImage=("url(../src/Image/"+imgList[index1]+".jpg)")},2000);
    setTimeout(function (){upperElement.style.opacity=1},2500);
    setTimeout(function (){lowerElement.style.backgroundImage=("url(../src/Image/"+imgList[index2]+".jpg)")},3000);

},5000);

