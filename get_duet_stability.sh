if [ "x$2" = "x" ]; then
  protein_name="2OCJ"
else
  protein_name=$2
fi
if [ "x$1" = "x" ]; then
  mutation_name="F134L"
else
  mutation_name=$1
fi
echo "Mutation", $mutation_name
echo "Protein", $protein_name

cmd="curl 'http://bleoberis.bioc.cam.ac.uk/duet/stability_prediction' -H 'Pragma: no-cache' -H 'Origin: http://bleoberis.bioc.cam.ac.uk' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2182.3 Safari/537.36' -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryWMZDQNBEvcqcZF29' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Referer: http://bleoberis.bioc.cam.ac.uk/duet/stability' -H 'Cookie: _ga=GA1.3.1543078565.1414217154' -H 'Connection: keep-alive' --data-binary $'------WebKitFormBoundaryWMZDQNBEvcqcZF29\r\nContent-Disposition: form-data; name=\"wild\"; filename=\"\"\r\nContent-Type: application/octet-stream\r\n\r\n\r\n------WebKitFormBoundaryWMZDQNBEvcqcZF29\r\nContent-Disposition: form-data; name=\"pdb_code\"\r\n\r\n$protein_name\r\n------WebKitFormBoundaryWMZDQNBEvcqcZF29\r\nContent-Disposition: form-data; name=\"mutation\"\r\n\r\n$mutation_name\r\n------WebKitFormBoundaryWMZDQNBEvcqcZF29\r\nContent-Disposition: form-data; name=\"chain\"\r\n\r\nA\r\n------WebKitFormBoundaryWMZDQNBEvcqcZF29\r\nContent-Disposition: form-data; name=\"run\"\r\n\r\nsingle\r\n------WebKitFormBoundaryWMZDQNBEvcqcZF29\r\nContent-Disposition: form-data; name=\"mutation_sys\"\r\n\r\n\r\n------WebKitFormBoundaryWMZDQNBEvcqcZF29\r\nContent-Disposition: form-data; name=\"chain_sys\"\r\n\r\n\r\n------WebKitFormBoundaryWMZDQNBEvcqcZF29--\r\n' --compressed"
echo $cmd > ./.temp_cmd.sh
./.temp_cmd.sh > Duet_$mutation_name-$protein_name.html
rm ./.temp_cmd.sh
