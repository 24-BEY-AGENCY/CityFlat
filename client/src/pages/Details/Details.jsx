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
      height: "90vh",
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
        <div className="_details_big_container">
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
          <div className="_inner_container">
            <div className="left_side">
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
              <span>test</span>
            </div>
            <div className="right_side">
              <div className="right_box">
                <span className="_title">reservation details :</span>
                <div
                  className="right_box_inner_container"
                  style={{ marginBottom: "1rem" }}
                >
                  <div className="first_square">
                    <span className="_medium_title">calendar</span>
                  </div>
                  <div className="square">
                    <span className="_small_title">12/12/12 - 12/12/12</span>
                    <span className="_small_title">night : 2</span>
                  </div>
                  <div className="first_square">
                    <span className="_medium_title">services</span>
                  </div>
                  <div className="square">
                    <span className="_small_title">
                      <svg
                        width="15"
                        height="15"
                        viewBox="0 0 15 15"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <g clip-path="url(#clip0_44_962)">
                          <path
                            d="M6.68384 12.6431L7.70703 13.6663L8.7302 12.6431H6.68384Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M6.58174 5.73816H4.66405C2.57574 5.73816 0.864863 7.38523 0.762207 9.44849H10.4836C10.3809 7.38526 8.67008 5.73816 6.58174 5.73816ZM4.06423 8.30193H3.07593V7.42302H4.06423V8.30193ZM6.11706 7.76785H5.12876V6.88894H6.11706V7.76785ZM8.16989 8.30193H7.18159V7.42302H8.16989V8.30193Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M8.03101 14.5851H9.41476C10.0067 14.5851 10.4883 14.1035 10.4883 13.5115V12.6431H9.97301L8.03101 14.5851Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M0.757324 12.6431V13.5115C0.757324 14.1035 1.23891 14.5851 1.83088 14.5851H7.38287L5.44087 12.6431H0.757324Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M11.6408 3.75482V1.29395H13.7287V0.415039H10.7619V3.75482H7.40283V4.8592H14.9999V3.75482H11.6408Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M11.3674 9.64487V9.68805C11.8215 9.97003 12.1246 10.4731 12.1246 11.0458C12.1246 11.6185 11.8215 12.1215 11.3674 12.4035V13.5116C11.3674 13.9079 11.2484 14.2768 11.0446 14.5851H13.3492L14.1918 5.73816H9.34277C10.5669 6.60582 11.3674 8.03357 11.3674 9.64487Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M10.5272 10.3274H0.718389C0.322266 10.3274 0 10.6497 0 11.0458C0 11.4419 0.322266 11.7642 0.718389 11.7642H10.5272C10.9233 11.7642 11.2455 11.4419 11.2455 11.0458C11.2455 10.6497 10.9233 10.3274 10.5272 10.3274Z"
                            fill="#BCBCBC"
                          />
                        </g>
                        <defs>
                          <clipPath id="clip0_44_962">
                            <rect width="15" height="15" fill="white" />
                          </clipPath>
                        </defs>
                      </svg>
                      food
                    </span>
                    <span className="_small_title">
                      <svg
                        width="16"
                        height="10"
                        viewBox="0 0 16 10"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          d="M15.9738 6.77168L14.8238 3.90169C14.7418 3.74753 14.5824 3.6509 14.4079 3.6509H11.9592L9.27104 1.10476C9.18361 1.02235 9.06843 0.97583 8.94715 0.97583H3.41558C3.21119 0.97583 3.02867 1.10916 2.96724 1.30478L2.22372 3.6509H0.469548C0.209525 3.6509 0 3.86151 0 4.1213V5.33363V6.90745C0 7.10952 0.162621 7.27287 0.364844 7.27287L1.49886 7.27241C1.5013 8.23894 2.28786 9.02422 3.25601 9.02422C4.22227 9.02422 5.01056 8.2389 5.01315 7.27241H10.7547C10.7581 8.23894 11.5451 9.02422 12.5116 9.02422C13.4794 9.02422 14.2661 8.2389 14.269 7.27241L15.6343 7.27287C15.7564 7.27287 15.8693 7.21229 15.937 7.11195C16.0052 7.01192 16.0189 6.884 15.9738 6.77168ZM3.25605 8.02056C2.84082 8.02056 2.50225 7.68277 2.50225 7.267C2.50225 6.85181 2.84082 6.51417 3.25605 6.51417C3.67108 6.51417 4.00872 6.85185 4.00872 7.267C4.00876 7.68273 3.67112 8.02056 3.25605 8.02056ZM6.14976 3.72068H3.77385L4.29633 1.86215H6.14976V3.72068ZM6.90352 3.72068V1.86215H8.20444L10.0329 3.72068H6.90352ZM12.5116 8.02056C12.0964 8.02056 11.7594 7.68277 11.7594 7.267C11.7594 6.85181 12.0964 6.51417 12.5116 6.51417C12.9278 6.51417 13.2649 6.85185 13.2649 7.267C13.2649 7.68273 12.9279 8.02056 12.5116 8.02056Z"
                          fill="#BCBCBC"
                        />
                      </svg>
                      parking
                    </span>
                  </div>
                </div>
                <span className="_title">Payment Details :</span>
                <div className="right_box_inner_container">
                  <div className="first_square">
                    <span className="_medium_title">night fees</span>
                  </div>

                  <div className="square">
                    <span className="_small_title">400€</span>
                    <span className="_small_title">2 * 200€</span>
                  </div>
                  <div className="first_square">
                    <span className="_medium_title">services</span>
                  </div>
                  <div className="square">
                    <span className="_small_title">
                      <svg
                        width="15"
                        height="15"
                        viewBox="0 0 15 15"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <g clip-path="url(#clip0_44_962)">
                          <path
                            d="M6.68384 12.6431L7.70703 13.6663L8.7302 12.6431H6.68384Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M6.58174 5.73816H4.66405C2.57574 5.73816 0.864863 7.38523 0.762207 9.44849H10.4836C10.3809 7.38526 8.67008 5.73816 6.58174 5.73816ZM4.06423 8.30193H3.07593V7.42302H4.06423V8.30193ZM6.11706 7.76785H5.12876V6.88894H6.11706V7.76785ZM8.16989 8.30193H7.18159V7.42302H8.16989V8.30193Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M8.03101 14.5851H9.41476C10.0067 14.5851 10.4883 14.1035 10.4883 13.5115V12.6431H9.97301L8.03101 14.5851Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M0.757324 12.6431V13.5115C0.757324 14.1035 1.23891 14.5851 1.83088 14.5851H7.38287L5.44087 12.6431H0.757324Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M11.6408 3.75482V1.29395H13.7287V0.415039H10.7619V3.75482H7.40283V4.8592H14.9999V3.75482H11.6408Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M11.3674 9.64487V9.68805C11.8215 9.97003 12.1246 10.4731 12.1246 11.0458C12.1246 11.6185 11.8215 12.1215 11.3674 12.4035V13.5116C11.3674 13.9079 11.2484 14.2768 11.0446 14.5851H13.3492L14.1918 5.73816H9.34277C10.5669 6.60582 11.3674 8.03357 11.3674 9.64487Z"
                            fill="#BCBCBC"
                          />
                          <path
                            d="M10.5272 10.3274H0.718389C0.322266 10.3274 0 10.6497 0 11.0458C0 11.4419 0.322266 11.7642 0.718389 11.7642H10.5272C10.9233 11.7642 11.2455 11.4419 11.2455 11.0458C11.2455 10.6497 10.9233 10.3274 10.5272 10.3274Z"
                            fill="#BCBCBC"
                          />
                        </g>
                        <defs>
                          <clipPath id="clip0_44_962">
                            <rect width="15" height="15" fill="white" />
                          </clipPath>
                        </defs>
                      </svg>
                      25€
                    </span>
                    <span className="_small_title">
                      <svg
                        width="16"
                        height="10"
                        viewBox="0 0 16 10"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          d="M15.9738 6.77168L14.8238 3.90169C14.7418 3.74753 14.5824 3.6509 14.4079 3.6509H11.9592L9.27104 1.10476C9.18361 1.02235 9.06843 0.97583 8.94715 0.97583H3.41558C3.21119 0.97583 3.02867 1.10916 2.96724 1.30478L2.22372 3.6509H0.469548C0.209525 3.6509 0 3.86151 0 4.1213V5.33363V6.90745C0 7.10952 0.162621 7.27287 0.364844 7.27287L1.49886 7.27241C1.5013 8.23894 2.28786 9.02422 3.25601 9.02422C4.22227 9.02422 5.01056 8.2389 5.01315 7.27241H10.7547C10.7581 8.23894 11.5451 9.02422 12.5116 9.02422C13.4794 9.02422 14.2661 8.2389 14.269 7.27241L15.6343 7.27287C15.7564 7.27287 15.8693 7.21229 15.937 7.11195C16.0052 7.01192 16.0189 6.884 15.9738 6.77168ZM3.25605 8.02056C2.84082 8.02056 2.50225 7.68277 2.50225 7.267C2.50225 6.85181 2.84082 6.51417 3.25605 6.51417C3.67108 6.51417 4.00872 6.85185 4.00872 7.267C4.00876 7.68273 3.67112 8.02056 3.25605 8.02056ZM6.14976 3.72068H3.77385L4.29633 1.86215H6.14976V3.72068ZM6.90352 3.72068V1.86215H8.20444L10.0329 3.72068H6.90352ZM12.5116 8.02056C12.0964 8.02056 11.7594 7.68277 11.7594 7.267C11.7594 6.85181 12.0964 6.51417 12.5116 6.51417C12.9278 6.51417 13.2649 6.85185 13.2649 7.267C13.2649 7.68273 12.9279 8.02056 12.5116 8.02056Z"
                          fill="#BCBCBC"
                        />
                      </svg>
                      20€
                    </span>
                  </div>
                </div>
                <div className="right_box_footer">
                  <div className="_right_box_footer_square">
                    <p className="_medium_title">night fees</p>
                    <p className="_medium_title">200€</p>
                  </div>
                  <div className="square" id="_right_box_button">
                    <button>rent now</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
