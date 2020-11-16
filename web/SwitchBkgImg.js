
var imgList=["bkgImg1","bkgImg2","bkgImg3","bkgImg4","bkgImg5","bkgImg6"];
var index1=0;
var index2=2;

var timeFade = null;

function fadeOut(){
    var presentImg = document.getElementById(imgList[index1]);
    timeFade = setInterval(function (){
        presentImg.style.opacity -= 0.01;
        if (presentImg.style.opacity == 0){
            clearInterval(timeFade);
            for (var i=0;i<6;i++){
                document.getElementById(imgList[i]).style.zIndex++;
                if (document.getElementById(imgList[i]).style.zIndex == 7){
                    document.getElementById(imgList[i]).style.zIndex = 1;
                }
            }
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
    document.getElementById(imgList[index2]).style.opacity = 1;
    fadeOut();
},5000);