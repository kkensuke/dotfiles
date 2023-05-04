# openssl encryption (-pass pass:"$2")
enc(){
	if [[ -f "$1" ]] ; then
		openssl enc -aes-256-cbc -salt -in "$1" -out encf-"$1" -pass pass:"$2";
	elif [[ -d "$1" ]]; then
		tar -vczf "$1".tar.gz "$1" ;
		openssl enc -aes-256-cbc -salt -in "$1".tar.gz -out encd-"$1" -pass pass:"$2";
		rm -rf "$1".tar.gz;
	else
		echo "can't encrypt";
	fi
}
dec(){
	if [[ "$1" == encf-* ]] ; then
		openssl enc -d -aes-256-cbc -salt -in "$1" -out decf-$(sed 's/encf-//g' <<< "$1") -pass pass:"$2";
	elif [[ "$1" == encd-* ]]; then
		openssl enc -d -aes-256-cbc -salt -in "$1" -out decd-$(sed 's/encd-//g' <<< "$1").tar.gz -pass pass:"$2";
		tar -xvzf decd-$(sed 's/encd-//g' <<< "$1").tar.gz;
		rm -rf decd-$(sed 's/encd-//g' <<< "$1").tar.gz;
	else
		echo "can't decrypt";
	fi
}

# zip encrypttion
zipen(){
	zip -er enc.zip "$@"
}
