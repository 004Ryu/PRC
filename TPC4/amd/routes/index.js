var express = require("express");
var router = express.Router();
var axios = require("axios");

var prefixes = `
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX owl: <http://www.w3.org/2002/07/owl#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX noInferences: <http://www.ontotext.com/explicit>
    PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
    PREFIX amd: <http://prc.di.uminho.pt/2020/amd#>
`;

var getLink = "http://localhost:7200/repositories/amd" + "?query=";

/* GET home page. */
router.get("/", function(req, res, next) {
  var query = `select ?tit (count(?part) as ?numPartituras) ?id where {
      ?id rdf:type amd:Obra .
      ?id amd:temPartitura ?part .
      ?id amd:título ?tit
    } 
    group by ?tit ?id
    order by ?tit`;

  var encoded = encodeURIComponent(prefixes + query);
  axios
    .get(getLink + encoded)
    .then(dados => {
      var mydata = [];
      mydata = dados.data.results.bindings.map(obra => {
        return {
          id: obra.id.value.split("#")[1],
          tit: obra.tit.value,
          nparts: obra.numPartituras.value
        };
      });
      res.render("index", { obras: mydata });
    })
    .catch(erro => {
      res.render("error", { error: erro });
    });
});

router.get("/obras/:idObra", function(req, res, next) {
  console.log("Obra " + req.params.idObra);

  var queryObra =
    `
  select ?tit ?tipo ?comp ?arr ?id where {
        ?id rdf:type amd:Obra FILTER(?id = amd:` +
    req.params.idObra +
    `) .
        ?id amd:título ?tit .
        ?id amd:tipo ?tipo .
        ?id amd:éCompostaPor ?comp .
        OPTIONAL { ?id amd:éArranjadaPor ?arr }
      } 
      group by ?tit ?id ?tipo ?comp ?arr
      order by ?tit`;

  var queryParts =
    `
  select ?inst ?voz ?clave ?afina ?part where {
    ?o rdf:type amd:Obra FILTER(?o = amd:` +
    req.params.idObra +
    `) .
    ?o amd:temPartitura ?part .
    OPTIONAL{ ?part amd:éTocadaPor ?inst }
    OPTIONAL{ ?part amd:afinação ?afina }
    OPTIONAL{ ?part amd:voz ?voz }
    OPTIONAL{ ?part amd:clave ?clave }
  } 
  group by ?inst ?voz ?clave ?afina ?part
  order by ?part`;

  var encodedObra = encodeURIComponent(prefixes + queryObra);
  var encodedParts = encodeURIComponent(prefixes + queryParts);

  axios
    .all([axios.get(getLink + encodedObra), axios.get(getLink + encodedParts)])
    .then(
      axios.spread((obra, partituras) => {
        var parts = [];

        o = obra.data.results.bindings.map(obra => {
          if (obra.tit) tit = obra.tit.value;
          else tit = "";
          if (obra.comp) comp = obra.comp.value.split("#")[1];
          else comp = "";
          if (obra.tipo) tipo = obra.tipo.value;
          else tipo = "";
          if (obra.arr) arr = obra.arr.value.split("#")[1];
          else arr = "";

          return {
            id: obra.id.value.split("#")[1],
            tit: tit,
            comp: comp,
            tipo: tipo,
            arr: arr
          };
        });

        parts = partituras.data.results.bindings.map(part => {
          if (part.voz) voz = part.voz.value;
          else voz = "";
          if (part.clave) clave = part.clave.value;
          else clave = "";
          if (part.afina) afina = part.afina.value;
          else afina = "";

          return {
            inst: part.inst.value.split("#")[1],
            voz: voz,
            clave: clave,
            afina: afina
          };
        });
        console.log("Obra: " + JSON.stringify(o[0]));
        res.render("obra", { obra: o[0], parts: parts });
      })
    )
    .catch(erro => {
      res.render("error", { error: erro });
    });
});

module.exports = router;
