#!/bin/sh


if [ $# != 0 ] ; then
 echo ""
 echo ""
 echo "   Usage : tric_mkcomplog.sh"
 echo "   ex.) tric_mkcomplog.sh"
 echo ""
 echo "" 
 echo ""
 echo ""
 exit
fi

echo ""
echo " Extracting the comparison frame fits from header "
echo ""



if [ -e fitsHg.log ];then rm fitsHg.log ; fi
if [ -e fitsNe.log ];then rm fitsNe.log ; fi
if [ -e fitsXe.log ];then rm fitsXe.log ; fi
if [ -e fitsFlat.log ];then rm fitsFlat.log ; fi

			  


ls TRCS*fits > inp_comp.lst
for n in `cat inp_comp.lst`
do
# n=TRCS00141860.fits   
#  echo "making ${n} headlist..."   
  printf "images \n\
  imutil \n\
  imheader imlist=$n longhea=yes > hd_${n}.lst \n\
  logout "| cl > hoge1${n}.lst
  rm hoge1${n}.lst
  
  awk '{
  if ($1=="LAMP-HG" && $3=="1") print "Y"
  }' hd_${n}.lst > ohg.lst
  if [ -s ohg.lst ];then
  echo " Extracting Hg lamp "   
  sed s/"'"/""/g hd_${n}.lst | awk '{if($1=="FRAMEID")
  print $3".fits"}' >> fitsHg.log    
  fi

  
  awk '{
  if ($1=="LAMP-NE" && $3=="1") print "Y"
  }' hd_${n}.lst > one.lst
  if [ -s one.lst ];then
  echo " Extracting Ne lamp "         
  sed s/"'"/""/g hd_${n}.lst | awk '{if($1=="FRAMEID")
  print $3".fits"}' >> fitsNe.log
  fi

  awk '{
  if ($1=="LAMP-XE" && $3=="1") print "Y"
  }' hd_${n}.lst > oxe.lst
  if [ -s oxe.lst ];then
  echo " Extracting Ne lamp "    
  sed s/"'"/""/g hd_${n}.lst | awk '{if($1=="FRAMEID")
  print $3".fits"}' >> fitsXe.log
  fi

  awk '{
  if ($1=="LAMP-FLT=" && $2=="1") print $3
  }' hd_${n}.lst > oflt.lst
  if [ -s oflt.lst ];then
   echo " Extracting Flat lamp "  

  sed s/"'"/""/g hd_${n}.lst | awk '{if($1=="FRAMEID")
  print $3".fits"}' >> fitsFlat.log
  fi
  
  rm hd_${n}.lst
  
 done

 
