function metaObra(ident) {
  console.log("Apresentando a obra: " + ident);
  axios
    .get("/obras/" + ident)
    .then(response => window.location.assign("/obras/" + ident))
    .catch(error => console.log(error));
}
