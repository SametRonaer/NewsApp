import 'package:flutter/material.dart';

class CommunicationScreen extends StatelessWidget {
  static final String routeName = "/communicationScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("İris Hakkında"),
            SizedBox(width: 30),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/iris_logo.png"),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                "İris vasıtasıyla gün içerisinde gelişen olayları seçtiğiniz "
                "haber kaynaklarından herhangi bir reklama maruz kalmadan takip edebilirsiniz. "
                "\n"
                "\n"
                "Seçeceğiniz haber kaynaklarınız ile İris'inizi kişiselleştirip sadece odaklanmak "
                "istediğiniz medya kuruluşlarını takip edebilirsiniz.Bunun yanı sıra ekonomi, "
                "spor, dünya gibi başlıklar altında sadece belirli bir kategorideki haberleri de "
                "takip edebilirsiniz. "
                "\n"
                "\n"
                "İlginizi çeken haberleri daha sonra göz atmak için kaydedebilir"
                " ya da arkadaşlarınızla paylaşabilirsiniz. "
                "\n"
                "\n"
                "Her türlü görüş ve önerileriniz için bize"
                " aşağıdaki iletişim kanalları üzerinden ulaşabilirsiniz."
                "\n"
                "\n"
                "Mail: irisuygulamasi@gmail.com"
                "\n"
                "\n"
                "Telefon: +90 507 362 4701",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
