
var music=document.getElementById("audiosrc");
var index=0;
var musicList=["放課後ティータイム - ふわふわ時間.mp3","茅原実里 - エイミー.mp3","放課後ティータイム - おはよう､またあした.mp3","放課後ティータイム - Don't say “lazy”.mp3"];
var btn=document.getElementById("musicPlay");

function getMusic(){
    music.src="Music/"+musicList[index];
    document.getElementById("TrackTitle").innerHTML=musicList[index].replace(".mp3","&nbsp");
}

function playMusic(){
    if (music.paused){
        music.play();
        btn.style.background="url(musicpause.png) no-repeat";
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
        btn.style.background="url(musicplay.png) no-repeat";
    }
}

function nextMusic(){
    index ++;
    if (index >= musicList.length){
        index = 0;
    }
    getMusic();
    music.play();
    btn.style.background="url(musicpause.png) no-repeat";
}

function prevMusic(){
    index --;
    if (index < 0){
        index = musicList.length - 1;
    }
    getMusic();
    music.play();
    btn.style.background="url(musicpause.png) no-repeat";
}

window.onload=function (){
    music.volume=0.5;
    getMusic();
}