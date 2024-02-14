import "./App.css";
import "bootstrap/dist/css/bootstrap.css";
import Details from "./pages/Details/Details";
import Home from "./pages/Home/Home";
import Dashboard from "./pages/Dashboard/Dashboard";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import "swiper/css/effect-coverflow";
import "swiper/css/pagination";

// import required modules
import { EffectCoverflow, Pagination } from "swiper/modules";
import { useState } from "react";
function App() {

 
  return (
    <>
      <Home/>
      {/* <Details /> */}
      {/* <Dashboard/> */}

      {/* <Swiper
        effect={"coverflow"}
        grabCursor={true}
        centeredSlides={true}
        slidesPerView={"auto"}
        coverflowEffect={{
          rotate: 50,
          stretch: 0,
          depth: 100,
          modifier: 1,
          slideShadows: true,
        }}
        pagination={true}
        modules={[EffectCoverflow, Pagination]}
        className="mySwiper_branches"
        initialSlide={middleIndex}
        onSlideChange={(swiper) => setActiveSlideIndex(swiper.activeIndex)}
      >
        {BranchesData.map((el, i) => (
          <SwiperSlide key={i} className="branches">
            <img src={el.img} />
            <div className="expandable-boxes">
              <div
                className={`expandable-box ${
                  activeSlideIndex === i ? "open" : ""
                }`}
              >
                <span
                  className="d-flex justify-content-center align-items-center"
                  style={{
                    background:
                      "linear-gradient(180deg, rgba(100, 233, 236, 0.50) 0%, rgba(182, 245, 246, 0.50) 35.94%, rgba(255, 255, 255, 0.50) 100%)",
                    borderRadius: "50%",
                    height: "50px",
                    width: "50px",
                  }}
                >
                  {el.icon}
                </span>
                {activeSlideIndex === i && (
                  <span
                    style={{
                      color: "#1F2349",
                      fontWeight: 700,
                      textTransform: "uppercase",
                    }}
                  >
                    {el.description}
                  </span>
                )}
              </div>
            </div>
          </SwiperSlide>
        ))}
      </Swiper> */}

    </>
  );
}

export default App;
