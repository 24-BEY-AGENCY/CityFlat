import React, { useState } from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import "swiper/css/pagination";
import { Pagination } from "swiper/modules";
import "./TestimonialsSlider.css";

export default function TestimonialsSlider() {
  return (
    <>
      {" "}
      <Swiper
        slidesPerView={"auto"}
        spaceBetween={30}
        centeredSlides={true}
        pagination={{
          clickable: true,
        }}
        modules={[Pagination]}
        autoplay={{
          disableOnInteraction: true,
        }}
        initialSlide={1}
        className="swiper-wrapper"
      >
        <SwiperSlide className="swiper-slide">
          <div class="swiper-image">
            <div class="image">
              
            </div>
          </div>
        </SwiperSlide>
        <SwiperSlide className="swiper-slide">
          <div class="swiper-image">
            <div class="image"></div>
          </div>
        </SwiperSlide>
        <SwiperSlide className="swiper-slide">
          <div class="swiper-image">
            <div class="image"></div>
          </div>
        </SwiperSlide>
        <SwiperSlide className="swiper-slide">
          <div class="swiper-image">
            <div class="image"></div>
          </div>
        </SwiperSlide>
        <SwiperSlide className="swiper-slide">
          <div class="swiper-image">
            <div class="image"></div>
          </div>
        </SwiperSlide>
      </Swiper>
    </>
  );
}
