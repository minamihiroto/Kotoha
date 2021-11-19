import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Adsense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background-sample.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "広告が表示される理由",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 30),
              child: Text(
                '「Kotoha」をご利用のお客様へ\n\n初めまして、管理人のミナミと申します。\nいつも本当にありがとうございます。\n\nそして、煩わしい思いをさせてしまい大変申し訳ございません。\n\nここではなぜ\n「Kotoha」を利用するにあたって\n広告が流れるのかを\nお話しできればと思います。\n\n「Kotoha」は完全無料で利用できます。\nしかし、「Kotoha」は\n無料で動いているわけではありません。\n\n運用費や開発費、イラスト費などあらゆるところで代金が発生しております。\nお客様に広告を流させていただくことで、\n私が広告費を受け取り、\n運営費用にさせていただいております。\n\n「Kotoha」は\n私が個人で開発させていただいているサービスになりますので\n至らない点が多いかもしれません。\nそれでももしこのサービスを\nより便利に使いたい\n応援したいと\n思ってくださる方がいらっしゃいましたら\nぜひプレミアムプランにて\n「Kotoha」を\nご利用いただけましたら幸いです。\n\nこれからもサービス向上に\n努めてまいりますので、\n何卒ご理解のほどよろしくお願いします。\n\nストアレビューにてみなさんの\n感想・要望など\nお待ちしております！\nひとつひとつ大切に\n読ませていただいております。\n\nby ミナミ ヒロト\n\n',
                style:
                    TextStyle(color: Colors.white, fontSize: 18, height: 1.8),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
