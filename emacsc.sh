##
# emacs23_configer
# require("git", "wget", "sbt-0.11.0")
##
W=`pwd`
T=.emacs.d

## task::clear 
cd /tmp

rm -rf $T && mkdir $T

if [ -n "$1" ] ;then
  for d in ./emacs-starter-kit ./emacs-dotfiles ./auto-complete ./ensime
  do
    if [ -d d ]; then
      rm -rf d
    fi
  done
fi

## task::get emacs-kits 
echo "get emacs-starter-kit[https://github.com/technomancy/emacs-starter-kit.git]..."
if [ -d ./emacs-starter-kit ]; then
	echo "..."
else
  git clone https://github.com/technomancy/emacs-starter-kit.git
  cd emacs-starter-kit
  git checkout master
  cd ..
fi

echo "get emacs-dotfiles[https://github.com/g-eorge/emacs-dotfiles.git]..."
if [ -d ./emacs-dotfiles ]; then
	echo "check emacs-dotfiles..."
else
  git clone https://github.com/g-eorge/emacs-dotfiles.git
fi

echo "download auto-complete..."
if [ -f ./auto-complete-1.3.1.tar.bz2 ]; then
  echo "check auto-complete..."
else
  wget http://cx4a.org/pub/auto-complete/auto-complete-1.3.1.tar.bz2
  tar -jxvf auto-complete-1.3.1.tar.bz2
  mv auto-complete-1.3.1 auto-complete
fi

echo "download ensime"
if [ -d ./ensime ]; then
  echo "check ensime..."
else
  #wget https://github.com/downloads/aemoncannon/ensime/ensime_2.9.1-0.7.6.tar.gz
  #tar -zxvf ensime_2.9.1-0.7.6.tar.gz
  #mv ensime_2.9.1-0.7.6 ensime
  git clone https://github.com/aemoncannon/ensime.git --depth 1
fi
cd ensime
sbt update stage
cd ..

## task::assemble
cp -r emacs-starter-kit/* $T/

cp emacs-dotfiles/custom.el $T/

cp -r emacs-dotfiles/vendor $T/
cp -r auto-complete/* $T/vendor/auto-complete/
cp -r ensime/dist/* $T/vendor/ENSIME/

cp $W/itang.el $T/


## task::doit
if [ -d ~/.emacs.d ]; then
	echo "backup ~/.emacs.d "
	rm -rf ~/.emacs.d.bak
	mv ~/.emacs.d ~/.emacs.d.bak
fi
cp -r $T ~/

