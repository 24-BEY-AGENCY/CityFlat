import React, { useEffect } from "react";
import "./Details.css";
import Navbar from "../../components/navbar/Navbar";
import GLightbox from "glightbox";
import "glightbox/dist/css/glightbox.css";

export default function Details() {
  useEffect(() => {
    const lightbox = GLightbox({
      touchNavigation: true,
      loop: true,
      width: "90vw",
      height: "90vh"
    });

    // Clean up function
    return () => {
      lightbox.destroy();
    };
  }, []);
  return (
    <>
    
      <Navbar />
      <div className="_details">
        <div className="_container">
          <div className="photos-grid-title-container">
            <span>
              <svg
                width="22"
                height="22"
                viewBox="0 0 28 28"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <g clip-path="url(#clip0_43_680)">
                  <path
                    d="M3.67396 24.8759C3.67396 24.8759 3.64996 25.4799 4.23996 25.4799C4.97396 25.4799 11.051 25.4719 11.051 25.4719L11.061 19.8909C11.061 19.8909 10.965 18.9709 11.858 18.9709H14.684C15.74 18.9709 15.675 19.8909 15.675 19.8909L15.663 25.4539C15.663 25.4539 21.425 25.4539 22.33 25.4539C23.079 25.4539 23.045 24.7019 23.045 24.7019V14.4129L13.649 6.05493L3.67396 14.4129V24.8759Z"
                    fill="#030104"
                  />
                  <path
                    d="M0 13.635C0 13.635 0.847 15.196 2.694 13.635L13.732 4.29704L24.081 13.577C26.219 15.119 27.02 13.577 27.02 13.577L13.732 1.54004L0 13.635Z"
                    fill="#030104"
                  />
                  <path
                    d="M23.83 4.27515H21.168L21.179 7.50315L23.83 9.75215V4.27515Z"
                    fill="#030104"
                  />
                </g>
                <defs>
                  <clipPath id="clip0_43_680">
                    <rect width="27.02" height="27.02" fill="white" />
                  </clipPath>
                </defs>
              </svg>
              / Appartement B
            </span>
          </div>
            <div id="gallery" class="photos-grid-container gallery">
              <div class="main-photo img-box">
                <a
                  href="https://plan-a.ca/wp-content/uploads/2022/12/4800_paul_pouliot_30207_web-scaled.jpg"
                  class="glightbox"
                  data-glightbox="type: image"
                >
                  <img
                    src="https://i.pinimg.com/736x/ed/1a/da/ed1adacf4d70edc03d87315ac3769a85.jpg"
                    alt="image"
                  />
                </a>
              </div>
              <div>
                <div class="sub">
                  <div class="img-box">
                    <a
                      href="https://resize.elle.fr/article/var/plain_site/storage/images/deco/reportages/visites-maisons/decouvrez-les-plus-beaux-appartements-du-monde/un-appartement-avec-piscine-a-rio-de-janeiro/90564826-1-fre-FR/Un-appartement-avec-piscine-a-Rio-de-Janeiro.jpg"
                      class="glightbox"
                      data-glightbox="type: image"
                    >
                      <img
                        src="https://plan-a.ca/wp-content/uploads/2022/12/4800_paul_pouliot_30207_web-scaled.jpg"
                        alt="image"
                      />
                    </a>
                  </div>
                  <div class="img-box">
                    <a
                      href="https://media.admagazine.fr/photos/6396e766908aebe5490fae15/16:9/w_2560%2Cc_limit/2.jpg"
                      class="glightbox"
                      data-glightbox="type: image"
                    >
                      <img
                        src="https://media.admagazine.fr/photos/6396e766908aebe5490fae13/master/w_1600%2Cc_limit/3.jpg"
                        alt="image"
                      />
                    </a>
                  </div>
                  <div class="img-box">
                    <a
                      href="https://www.la-petite-etoile.fr/storage/realisations/1/cuisine-sur-mesure-ouverte-dans-un-appartement-haussmannien-avec-bar-blanc-et-sol-en-marbre-main.jpg"
                      class="glightbox"
                      data-glightbox="type: image"
                    >
                      <img
                        src="https://media.admagazine.fr/photos/6396e766908aebe5490fae13/master/w_1600%2Cc_limit/3.jpg"
                        alt="image"
                      />
                    </a>
                  </div>
                  <div id="multi-link" class="img-box">
                    <a
                      href="https://media.admagazine.fr/photos/6396e76b05b5d166736411d5/master/w_1600%2Cc_limit/eba-haussmann-cusine-cachemire-tour-eiffel%2520(16).jpg"
                      class="glightbox"
                      data-glightbox="type: image"
                    >
                      <img
                        src="https://ebainteriors.com/img/containers/assets/blog/48-projet-lesage/01-cuisine-grise-bois-eba-1677674643.jpg/6e95c7003e5fc9255ebcb4177ec9b9da.jpg"
                        alt="image"
                      />
                      <div class="transparent-box">
                        <div class="caption">+3</div>
                      </div>
                    </a>
                  </div>
                </div>
              </div>
              <div id="more-img" class="extra-images-container hide-element">
                <a
                  href="https://st.hzcdn.com/simgs/pictures/cuisines/amenagement-cuisine-cube-architectes-img~85d101e306e85b52_14-9690-1-82b5ee9.jpg"
                  class="glightbox"
                  data-glightbox="type: image"
                >
                  <img
                    src="https://st.hzcdn.com/simgs/pictures/cuisines/cuisine-design-ouverte-dans-un-appartement-haussmannien-arte-concept-siematic-img~5dc17a5e0a904270_4-7078-1-b7641e3.jpg"
                    alt="image"
                  />
                </a>
                <a
                  href="https://st.hzcdn.com/simgs/pictures/cuisines/cuisine-design-ouverte-dans-un-appartement-haussmannien-arte-concept-siematic-img~b8c1470c0a9042ac_4-7079-1-4c2080b.jpg"
                  class="glightbox"
                  data-glightbox="type: image"
                >
                  <img
                    src="https://st.hzcdn.com/simgs/pictures/cuisines/cuisine-design-ouverte-dans-un-appartement-haussmannien-arte-concept-siematic-img~b8c1470c0a9042ac_4-7079-1-4c2080b.jpg"
                    alt="image"
                  />
                </a>
                <a
                  href="https://cdn.lecollectionist.com/__lecollectionist__/production/lp-destinations/25/1KZrQaNKRZyx7pxjReVu_729341d0-26e6-40b0-9015-b120da7c34f0.jpg?width=2880&q=65"
                  class="glightbox"
                  data-glightbox="type: image"
                >
                  <img
                    src="https://cdn.lecollectionist.com/__lecollectionist__/production/lp-destinations/25/1KZrQaNKRZyx7pxjReVu_729341d0-26e6-40b0-9015-b120da7c34f0.jpg?width=2880&q=65"
                    alt="image"
                  />
                </a>
              </div>
            </div>
        </div>
      </div>
    </>
  );
}
