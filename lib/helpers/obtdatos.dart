class Datosgenerales {
  funcioncurppais(curp) {
    // String result = '';
    String loc;
    if (curp == "") {
      loc = "";
    } else {
      loc = curp.substring(12, 13);
    }

    String result;
    if (loc == 'ne') {
      result = '';
    } else {
      result = 'México';
    }
    return result;
  }

  funcioncurpfn(curp) {
    int ano;
    int mes;
    int dia;
    if (curp == "") {
      ano = 0;
      mes = 0;
      dia = 0;
    } else {
      ano = int.parse(curp.substring(4, 6));
      mes = int.parse(curp.substring(6, 8));
      dia = int.parse(curp.substring(8, 10));
    }

    String digito;
    if (ano > 40) {
      digito = "19";
    } else {
      digito = "20";
    }
    String ret =
        '${dia.toString().padLeft(2, '0')}/${mes.toString().padLeft(2, '0')}/$digito$ano';
    //String result = curp.substring(11, 13);
    return ret;
    //GATA750803HDFSLL05
  }

  funcioncurpgen(curp) {
    //String result = '';
    String loc;
    if (curp == "") {
      loc = "";
    } else {
      loc = curp.substring(10, 11);
    }
    String result;
    if (loc == 'H') {
      result = 'Masculino';
    } else if (loc == 'M') {
      result = 'Femenino';
    } else {
      result = '';
    }
    return result;
//  //GATA750803HDFSLL05
  }

  funcioncurpna(curp) {
    String loc;
    if (curp == "") {
      loc = "";
    } else {
      loc = curp.substring(12, 13);
    }
    String result;
    if (loc == 'ne') {
      result = 'Extranjero';
    } else {
      result = 'Mexicana';
    }
    return result;
    //GATA750803HDFSLL05
  }

  funcioncurpln(curp) {
    Map countries = {
      "AGUASCALIENTES": "AS",
      "DISTRITO FEDERAL": "DF",
      "SONORA": "SR",
      "TAMAULIPAS": "TS",
      "VERACRUZ": "VZ",
      "ZACATECAS": "ZS",
      "SAN LUIS POTOSÍ": "SP",
      "CAMPECHE": "CC",
      "COLIMA": "CM",
      "CHIHUAHUA": "CH",
      "DURANGO": "DG",
      "GUERRERO": "GR",
      "JALISCO": "JC",
      "MICHOACÁN": "MN",
      "NAYARIT": "NT",
      "OAXACA": "OC",
      "QUERÉTARO": "QT",
      "BAJA CALIFORNIA": "BC",
      "BAJA CALIFORNIA SUR": "BS",
      "COAHUILA": "CL",
      "CHIAPAS": "CS",
      "GUANAJUATO": "GT",
      "HIDALGO": "HG",
      "MÉXICO": "MC",
      "MORELOS": "MS",
      "NUEVO LEÓN": "NL",
      "PUEBLA": "PL",
      "QUINTANA ROO": "QR",
      "SINALOA": "SL",
      "TABASCO": "TC",
      "TLAXCALA": "TL",
      "YUCATÁN": "YN",
      "NACIDO EN EL EXTRANJERO": "NE",
    };
    String result;
    if (curp == "") {
      result = "";
    } else {
      result = curp.substring(11, 13);
    }

    var key = countries.keys
        .firstWhere((k) => countries[k] == result, orElse: () => null);
    // // String result = curp.substring(4, 10);

    return key;
    //GATA750803HDFSLL05
  }
}
