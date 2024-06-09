# fablesearch

https://fablesearch.com/

![スクリーンショット 2024-06-09 23 58 49](https://github.com/mskk3215/fable_backend/assets/113247174/91d3f240-b753-4392-be03-fb5b4268b8a2)

フロントエンドのレポジトリはこちらです。
https://github.com/mskk3215/fable_frontend

# サービス概要

fablesearch は、昆虫採集を目的とする人たち向けのサービスです。
過去に昆虫に対する興味・関心が湧いて実物を見ようと思っても昆虫が生息する場所を探し出せなかったこと、
昆虫図鑑など昆虫画像一覧を取り扱うサービスはあるが、昆虫の場所を検索するサービスが無買ったことから
今回のサービスを開発しました。

# ER 図

![スクリーンショット 2024-06-09 19 20 17](https://github.com/mskk3215/fable_backend/assets/113247174/8dd37c9e-74cd-450f-be6a-a30aa6308345)

# インフラ構成図

![スクリーンショット 2024-01-21 0 27 53](https://github.com/mskk3215/fable_backend/assets/113247174/8956da03-ba4f-4486-a161-0d9583b1810b)

# 使用技術

### バックエンド

| Ruby 3.1.2|
| Rails 7.0.4|
| MySQL 8.1.0|
| jbuilder|
| geocoder, exifr|
| Rubocop|
| Rspec|

### フロントエンド

| TypeScript|
| React 18.2.0|
| Next.js 14.1.3 (app router)|
| MUI|
| react-google-maps/api|
| react-chartjs, leaflet|
| prettier, eslint|
| Jest,React Testing Library|

### インフラ

| Docker / Docker-Compose|
| Github Actions (ECR, ECS, Rubocop, Rspec,ESlint,Jest,RTL)|
| Nginx|
| AWS (Route53, CloudFront, S3,VPC, ALB, ECR, ECS Fargate, RDS, ACM, SSM, CloudWatch, IAM)|
| Terraform|

# 機能一覧

### ユーザー

- 新規登録機能
- ログイン機能、ゲストログイン機能、ログアウト機能
- マイページ表示機能
- プロフィール変更機能
- ユーザーページ表示機能
- フォロー追加・解除機能
- フォロー一覧表示機能
- シェアリング機能

### 投稿機能

- 投稿機能
- 複数投稿編集機能
- 複数投稿複数削除機能
- 投稿一覧機能
- 投稿並び替え機能
- 投稿詳細機能
- いいね機能

### 検索機能

- 公園検索機能
- ルート検索機能

### 分析機能

- 採集地域選択表示機能
- 採集率表示機能
- 採集済み/未採集リスト表示機能
- ランキング表示機能

# 工夫した点

## フロントエンド

- 完全 SPA 化で作成しました。
- モバイルで閲覧しやすいようにレスポンシブ対応をしました。
- MUI や react-chartjs、react-leaflet を使用してデザイン性のある UI を実現しました。
- Next.js の SSR をユーザーページに適用し、検索エンジンのクローラーに捕捉されやすくしました。
- シェアリング機能を実装することで、アプリがネット上で展開されやすくしました。
- 画像編集ページでは、画像情報をまとめて編集できるように複数選択機能を追加しました。
- ユーザーページでは、ログインしていない場合にログインを促すモーダルを表示し、ユーザー登録を促進しました。
- toast やロード中処理（スピナー、無限スクロール、プログレスバー）を追加し、エラーや動作状況をユーザーが把握しやすいようにしました。
- TypeScript（strict）、Prettier、ESLint、Jest を使用してコードの一貫性と品質を確保しました。

## バックエンド

- Rails API モードを使用してフロントエンドと完全に分離しました。
- exifr を使用して画像から撮影場所と撮影日を自動取得し表示することで、ユーザーの入力手間を省き、昆虫名と住所のデータを集めやすくしました。
- geocoder を使用して、未収集の昆虫の場所を特定の場所から近い順に表示できるようにしました。
- Rubocop と Rspec を使用してコードの一貫性と品質を確保しました。
- session_store を same_site: に設定し、アプリでの操作が一定時間ない場合に自動でログアウトすることでセキュリティを向上させました。

## インフラ

- GitHub Actions を用いて CI/CD パイプラインを構築し、コード品質を確保するとともに実装から本番環境へのデプロイを効率化しました。
- Terraform を使用してインフラ管理を容易にしました。
- CloudFront を使用して AWS 上でキャッシュを保存し、画像読み込みの速度を改善しました。
- SSM に環境変数を保存することで、環境変数の管理を容易にしました。

  以上をもって、当アプリの紹介は終わりになります。

最後まで閲覧いただき、ありがとうございます！
