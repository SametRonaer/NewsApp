enum AllNewsPapers {
  CnnNews,
  NtvNews,
  HaberturkNews,
  BBCNews,
  HurriyetNews,
  CumhuriyetNews,
  BirgunNews,
  DunyaNews,
  MilliyetNews,
  SabahNews,
  TakvimNews,
  StarNews,
  T24News,
}

class NewsPapers {
  static final List<Map<String, String>> allNewsPapersWithUrl = [
    {
      "title": AllNewsPapers.NtvNews.toString(),
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/commons/b/b5/NTV_logo.png"
    },
    {
      "title": AllNewsPapers.CnnNews.toString(),
      "imageUrl":
          "https://yt3.ggpht.com/ytc/AKedOLS-KBRCkXSVRL6TwhcSIZExe3dbrocmFN2goR0Ceww=s900-c-k-c0x00ffffff-no-rj"
    },
    {
      "title": AllNewsPapers.HaberturkNews.toString(),
      "imageUrl":
          "https://im.haberturk.com/2016/09/14/ver1473850385/1296680_620x410.jpg"
    },
    {
      "title": AllNewsPapers.BBCNews.toString(),
      "imageUrl":
          "https://ichef.bbci.co.uk/news/640/cpsprodpb/C32C/production/_98846994_bbcturkce.png"
    },
    {
      "title": AllNewsPapers.HurriyetNews.toString(),
      "imageUrl":
          "https://logowik.com/content/uploads/images/890_hurriyetgazetesi.jpg"
    },
    {
      "title": AllNewsPapers.CumhuriyetNews.toString(),
      "imageUrl":
          "https://www.cumhuriyet.com.tr/Archive/2019/6/12/1435511_resource/66.jpg"
    },
    {
      "title": AllNewsPapers.BirgunNews.toString(),
      "imageUrl":
          "https://static.birgun.net/resim/haber-detay-resim/2019/12/12/to-our-readers-660744-5.jpg"
    },
    {
      "title": AllNewsPapers.DunyaNews.toString(),
      "imageUrl":
          "https://media-exp1.licdn.com/dms/image/C560BAQGKIn3nm52lbw/company-logo_200_200/0/1576073798675?e=2159024400&v=beta&t=5T_CUOK90_P1Xk-2mc4kycgnR7KsS1DUUMq_-4DZHq0"
    },
    {
      "title": AllNewsPapers.MilliyetNews.toString(),
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/tr/archive/9/90/20130126180709%21Milliyet_logosu.png"
    },
    {
      "title": AllNewsPapers.SabahNews.toString(),
      "imageUrl":
          "https://cdn.freelogovectors.net/wp-content/uploads/2018/03/sabah-gazetesi-sabah-com-tr-logo.png"
    },
    {
      "title": AllNewsPapers.TakvimNews.toString(),
      "imageUrl": "https://itkv.tmgrup.com.tr/2020/07/15/1594845869785.png"
    },
    {
      "title": AllNewsPapers.StarNews.toString(),
      "imageUrl": "https://www.star.com.tr/_imgs/starkarelogo.jpg"
    },
    {
      "title": AllNewsPapers.T24News.toString(),
      "imageUrl": "https://t24.com.tr/share/twitter.jpg"
    },
  ];
}
