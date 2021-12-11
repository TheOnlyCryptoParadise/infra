images=`docker images --filter=reference='lewelyn/cryptoparadise*:latest' --format "{{.Repository}}:{{.Tag}}"`
for i in $images
do
	echo "pulling $i"
	docker pull $i
done

