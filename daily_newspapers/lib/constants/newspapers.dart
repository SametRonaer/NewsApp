enum AllNewsPapers { CnnNews, NtvNews, HaberturkNews, BBCNews }

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
  ];
}
