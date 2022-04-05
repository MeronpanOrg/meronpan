class TuMangaOnline {
  String orderItem;
  String orderDir;
  String title;
  String filterBy;
  String type;
  String demography;
  String status;
  String translationStatus;
  String webcomic;
  String yonkoma;
  String amateur;
  String erotic;
  String pg;

  TuMangaOnline(
      {this.orderItem = '',
      this.orderDir = '',
      this.title = '',
      this.filterBy = '',
      this.type = '',
      this.demography = '',
      this.status = '',
      this.translationStatus = '',
      this.webcomic = '',
      this.yonkoma = '',
      this.amateur = '',
      this.erotic = '',
      this.pg = '1'});

  toMap() {
    return {
      'order_item': orderItem,
      'order_dir': orderDir,
      'title': title,
      'pg': pg,
      'filter_by': filterBy,
      'type': type,
      'demography': demography,
      'status': status,
      'translation_status': translationStatus,
      'webcomic': webcomic,
      'yonkoma': yonkoma,
      'amateur': amateur,
      'erotic': erotic,
    };
  }

  String getSFWUrlPart(bool adultContent) {
    return adultContent
        ? ''
        : 'exclude_genders%5B%5D=6&exclude_genders%5B%5D=17&exclude_genders%5B%5D=18&exclude_genders%5B%5D=19&erotic=false';
  }

  String popularMangaRequest(bool adultContent) {
    return '/library?order_item=$orderItem&order_dir=$orderDir&filter_by=title${getSFWUrlPart(adultContent)}&_pg=1&page=$pg';
  }
}
