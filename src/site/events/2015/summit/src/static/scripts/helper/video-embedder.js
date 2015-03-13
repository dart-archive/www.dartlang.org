/**
 * Copyright 2014 Google Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

CDS.VideoEmbedder = (function() {

  function embed(element) {

    var containerElement = element.parentNode
        .querySelector('.session__header-image');
    var youtubeURL = /youtube\.com/;
    var urlToEmbed = element.dataset.embed;
    var iframe;

    if (!youtubeURL.test(urlToEmbed))
      return;

    if (containerElement.querySelector('iframe')) {
      iframe = containerElement.querySelector('iframe');
    } else {
      iframe = document.createElement('iframe');
      containerElement.appendChild(iframe);
    }

    iframe.setAttribute('width', '100%');
    iframe.setAttribute('height', '100%');
    iframe.setAttribute('src', urlToEmbed + '?autoplay=1');
    iframe.setAttribute('frameborder', '0');
    iframe.setAttribute('allowfullscreen', 'yes');
    iframe.classList.add('session__video-embed');

    element.classList.add('hidden');
  }

  function killAllEmbeddedVideos() {
    var videos = document.querySelectorAll('.session__video-embed');
    var videoEmbedFABS = document.querySelectorAll('.session__fab');

    for (var i = 0; i < videos.length; i++)
      videos[i].parentNode.removeChild(videos[i]);

    for (var j = 0; j < videoEmbedFABS.length; j++)
      videoEmbedFABS[j].classList.remove('hidden');
  }

  return {
    embed: embed,
    killAllEmbeddedVideos: killAllEmbeddedVideos
  };
})();
