(function () {
  var subtitle = document.querySelector("[data-dynamic-subtitle]");

  if (!subtitle) {
    return;
  }

  var phraseNode = subtitle.querySelector(".ai-welcome__subtitle-text");
  var phrases = (subtitle.getAttribute("data-phrases") || "")
    .split("|")
    .map(function (phrase) {
      return phrase.trim();
    })
    .filter(Boolean);

  if (!phraseNode || phrases.length < 2) {
    return;
  }

  var prefersReducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  if (prefersReducedMotion) {
    phraseNode.textContent = phrases[0];
    return;
  }

  var index = 0;

  window.setInterval(function () {
    index = (index + 1) % phrases.length;
    subtitle.classList.add("is-changing");

    window.setTimeout(function () {
      phraseNode.textContent = phrases[index];
      subtitle.classList.remove("is-changing");
    }, 190);
  }, 3400);
})();
