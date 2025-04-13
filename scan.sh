#!/usr/bin/bash 

#Number of files in the Target directory
num_files=$(ls /home/kali/Downloads | wc -l)

#Prints file names to the console
file_names=$(ls /home/kali/Downloads| tr " " "\n")

#If there is only one file present.
single_file=$(ls /home/kali/Downloads)

#This conditional will check if there's more than one file in the downloads directory and treat them as a set.
if [ $num_files -gt 1 ]
   then
   for file in $file_names #If more than one file in Downloads, handles them as a list.
        do
	hash=$(sha256sum /home/kali/Downloads/$file | awk '{print $1}') #This hashes each file with sha256.
	echo "Virustotal Result for $file"
	vt file $hash | grep malicious | uniq -c #This uses the Virustotal binary to query the database for the result of the specific hash.
	echo "......................................"
	echo " " 
    done
else
   single_hash=$(sha256sum /home/kali/Downloads/$single_file | awk '{print $1}') #This handles situations where there's just one single file present.
   echo "Virustotal result for $single_file"
   vt file $single_hash | grep malicious #The virustotal binary is used here with the hash to get the results.
   echo "................................"
   echo " "
fi

