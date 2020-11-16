
var music=document.getElementById("audiosrc");
var index=0;
var musicList=new Array("testmusic.mp3");

function getMusic(){
    music.src="../src/Music/"+musicList[index];
    document.getElementById("TrackTitle").innerHTML=musicList[index].replace(".mp3","&nbsp");
}

function playMusic(){
    var btn=document.getElementById("musicPlay");
    if (music.paused){
        music.play();
        btn.style.background="url(../src/musicpause.png) no-repeat";
        if (music.currentTime >= music.duration - 1){
            index ++;
            if (index >= musicList.length){
                index = 0;
            }
            getMusic();
            music.play();
        }
    }
    else {
        music.pause();
        btn.style.background="url(../src/musicplay.png) no-repeat";
    }
}

function nextMusic(){
    index ++;
    if (index >= musicList.length){
        index = 0;
    }
    getMusic();
    music.play();
}

function prevMusic(){
    index --;
    if (index < 0){
        index = musicList.length - 1;
    }
    getMusic();
    music.play();
}

window.onload=function (){
    getMusic();
}