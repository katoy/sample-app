
# API ドキュメントを生成/閲覧する

```console
# docker-compose --profile swagger up -d
```

docker-compe を --profile swagger を指定すると、 swagger 関連ツールのコンポーネントも稼働されるようになる。

```console
docker-compose run --rm app bash

OPENAPI=1 bundle exec rspec spec/requests/api/v1/tasks_spec.rb
cp doc/openapi.yml openapi/tasks.yaml
```

OPENAPI=! を指定して rspec を実行すると．doc/openapi.yaml が生成される。  
openapi/ に copy すると、opendoc/merged.yaml が更新される。  
merged.yaml を swagger-ui や redoc で, 開く。  

## redocで閲覧する

```console
$ docker run --name "$(basename $(pwd))_redoc" -d --rm -p 8001:80 \
   -v "$(pwd)/openapi/merged.yaml:/usr/share/nginx/html/merged.yaml" \
   -e SPEC_URL=merged.yaml -e PAGE_TITLE="SampleApp API" \
   redocly/redoc

$ open http://localhost:8001
```

## swagger-ui で閲覧する

```console
open http://localhost:8012
```

## html ファイルを生成する

```console
 % docker-compose run --rm redoc-cli bundle merged.yaml -o merged.html

 $ open openapi/merged.html
 ```

swagger 関連ツールをdocker で稼働させるのは,次を参考にしている。

- <https://qiita.com/minato-naka/items/3b0bcf0788a2150f3171>
 OpenAPI（Swagger）のAPI開発Docker環境を整備した
