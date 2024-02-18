import React, { useEffect, useState } from "react";
import "./AppartementsContent.css";
import apartement from "../../../../assets/homepage_mats/vue-du-modele-maison-3d.png";
import Modal from "../../../../components/modals/Modal";
import { useModal } from "../../../../hooks/useModal";
import { v4 as uuidv4 } from "uuid";

export default function AppartementsContent() {
  const { showModal, openModal, closeModal } = useModal();
  const [apartmentList, setApartmentList] = useState([]);
  const storedApartments = JSON.parse(localStorage.getItem("apartmentList"));
  const [formData, setFormData] = useState({
    apartmentName: "",
    price: "",
    startDate: "",
    endDate: "",
    newPrice: "",
    location: "",
    bedroom: 0,
    bathroom: 0,
    parking: "",
    food: "",
    pictures: [],
    description: "",
  });

  useEffect(() => {
    if (!showModal) {
      setFormData({
        apartmentName: "",
        price: "",
        startDate: "",
        endDate: "",
        newPrice: "",
        location: "",
        bedroom: 0,
        bathroom: 0,
        parking: "",
        food: "",
        pictures: [],
        description: "",
      });
    }
  }, [showModal]);

  useEffect(() => {
    if (storedApartments) {
      setApartmentList(storedApartments);
    }
  }, []);
  // const [images, setImages] = useState([]);

  // const handleImageChange = (event) => {
  //   const selectedImages = event.target.files;
  //   const newImages = [];

  //   for (let i = 0; i < selectedImages.length; i++) {
  //     const imageURL = URL.createObjectURL(selectedImages[i]);
  //     newImages.push({ id: i, url: imageURL });
  //   }

  //   setImages([...images, ...newImages]);
  // };

  // const handleRemoveImage = (id) => {
  //   const updatedImages = images.filter((image) => image.id !== id);
  //   setImages(updatedImages);
  // };

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleCounterChange = (type, value) => {
    const updatedValue = parseInt(formData[type]) + value;
    setFormData({ ...formData, [type]: updatedValue });
  };

  const handleImageChange = async (event) => {
    const selectedImages = event.target.files;
    const newPictures = [];

    for (let i = 0; i < selectedImages.length; i++) {
      const file = selectedImages[i];
      const base64Image = await convertToBase64(file);
      const id = Date.now() + i;
      newPictures.push({ id, url: base64Image });
    }

    setFormData((prevFormData) => ({
      ...prevFormData,
      pictures: [...prevFormData.pictures, ...newPictures],
    }));
  };

  const convertToBase64 = (file) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result);
      reader.onerror = (error) => reject(error);
    });
  };

  const handleRemoveImage = (id) => {
    const updatedPictures = formData.pictures.filter(
      (image) => image.id !== id
    );
    setFormData((prevFormData) => ({
      ...prevFormData,
      pictures: updatedPictures,
    }));
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    const updatedApartmentList = [
      ...apartmentList,
      { ...formData, id: Date.now() },
    ];
    setApartmentList(updatedApartmentList);
    localStorage.setItem("apartmentList", JSON.stringify(updatedApartmentList));
    setFormData({
      apartmentName: "",
      price: "",
      startDate: "",
      endDate: "",
      newPrice: "",
      location: "",
      bedroom1: "",
      bedroom2: "",
      service1: "",
      service2: "",
      service3: "",
      service4: "",
      pictures: [],
      description: "",
    });
    closeModal();
  };

  console.log(apartmentList);

  return (
    <>
      <div className="container-fluid py-4">
        <h1 className="h3 mb-0 text-start">
          Appartements ({apartmentList?.length})
        </h1>
      </div>
      <ul className="app_cards scrollable-container">
        <li className="app_cards_item">
          <div className="add_app_card">
            <div
              className="add_app_card_content d-flex align-items-center justify-content-center flex-column gap-2"
              onClick={() => {
                openModal();
              }}
            >
              <span>add a new appartement</span>
              <svg
                width="70"
                height="70"
                viewBox="0 0 70 70"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <rect
                  width="70"
                  height="70"
                  rx="20"
                  fill="white"
                  fill-opacity="0.08"
                />
                <rect
                  x="0.5"
                  y="0.5"
                  width="69"
                  height="69"
                  rx="19.5"
                  stroke="white"
                  stroke-opacity="0.16"
                />
                <path
                  d="M35.0198 36.4046L35.0198 48.7281H32.9802L32.9802 36.4046L20.6567 36.4046L20.6567 34.365L32.9802 34.365L32.9802 22.0414H35.0198L35.0198 34.365L47.3433 34.365L47.3433 36.4046L35.0198 36.4046Z"
                  fill="white"
                />
              </svg>
            </div>
          </div>
        </li>
        {apartmentList.map((app, i) => {
          return (
            <li className="app_cards_item">
              <div className="app_card">
                <div className="app_card_image">
                  <img src={app.pictures[0].url} />
                </div>

                <div className="app_card_content">
                  <div className="app_card_heading d-flex justify-content-between">
                    <span className="app_title">{app.apartmentName}</span>
                    <span className="app_title">
                      <svg
                        width="16"
                        height="15"
                        viewBox="0 0 16 15"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        style={{ paddingRight: 5 }}
                      >
                        <path
                          d="M7.66418 0.360352L9.46181 5.62357H15.279L10.5728 8.87641L12.3704 14.1396L7.66418 10.8868L2.95794 14.1396L4.75556 8.87641L0.0493164 5.62357H5.86656L7.66418 0.360352Z"
                          fill="#F1AF07"
                        />
                      </svg>
                      4.7
                    </span>
                  </div>
                  <p className="card-span">
                    <svg
                      width="9"
                      height="9"
                      viewBox="0 0 9 9"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <g clipPath="url(#clip0_161_2953)">
                        <path
                          d="M4.50296 0.195417C6.27031 0.135857 7.72168 1.55078 7.72168 3.30467C7.72168 5.29514 5.81151 6.73968 4.74087 8.81713C4.68651 8.92261 4.53467 8.92274 4.48012 8.81728C3.51157 6.948 1.85618 5.69454 1.5494 3.8937C1.23176 2.03018 2.61367 0.259112 4.50296 0.195417ZM4.61065 4.93425C5.51063 4.93425 6.24023 4.20463 6.24023 3.30467C6.24023 2.40471 5.51061 1.67509 4.61065 1.67509C3.71067 1.67509 2.98105 2.40471 2.98105 3.30467C2.98105 4.20463 3.71067 4.93425 4.61065 4.93425Z"
                          fill="#DEC25F"
                        />
                      </g>
                      <defs>
                        <clipPath id="clip0_161_2953">
                          <rect
                            width="8.7027"
                            height="8.7027"
                            fill="white"
                            transform="matrix(-1 0 0 1 8.96387 0.193665)"
                          />
                        </clipPath>
                      </defs>
                    </svg>
                    {app.location}
                  </p>
                  <div className="app_card_heading d-flex justify-content-between">
                    <div className="d-flex align-items-center gap-2">
                      <svg
                        width="38"
                        height="39"
                        viewBox="0 0 38 39"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <rect
                          y="0.899567"
                          width="37.7821"
                          height="37.7821"
                          rx="13.4936"
                          fill="#0DB254"
                          fillOpacity="0.05"
                        />
                        <path
                          d="M30.1049 20.1561C30.2535 19.8913 30.332 19.5907 30.3326 19.2846V18.9534C30.3327 18.7245 30.2893 18.4977 30.2046 18.2862C30.12 18.0746 29.9958 17.8823 29.8392 17.7203L29.0675 16.9273V16.6702H31.2307L30.7036 12.3129H26.5881L26.061 16.6702H28.2242V16.9273L27.4525 17.7203C27.2959 17.8823 27.1718 18.0746 27.0871 18.2862C27.0025 18.4977 26.959 18.7245 26.9592 18.9534V19.2846C26.9597 19.5907 27.0382 19.8913 27.1869 20.1561H25.2725V27.5635H32.0193V20.1561H30.1049ZM29.4892 22.3347H27.8025V21.4633H29.4892V22.3347ZM29.4892 25.3848H27.8025V24.5134H29.4892V25.3848Z"
                          fill="#0DB254"
                        />
                        <path
                          d="M24.0074 20.2912C24.0087 19.9162 23.9345 19.5451 23.7893 19.2015C23.644 18.8579 23.4311 18.5493 23.164 18.2955V11.8772H22.3207V12.7487H9.67039V11.8772H8.82704V18.2955C8.56036 18.5497 8.34769 18.8583 8.20251 19.2018C8.05733 19.5453 7.98282 19.9163 7.98369 20.2912V21.0276H7.56201V27.5635H8.40536V24.5134H23.5857V27.5635H24.429V21.0276H24.0074V20.2912ZM10.5137 17.5417V16.2345C10.5137 15.8878 10.647 15.5553 10.8843 15.3102C11.1215 15.065 11.4433 14.9273 11.7788 14.9273H14.3088C14.6443 14.9273 14.9661 15.065 15.2033 15.3102C15.4406 15.5553 15.5738 15.8878 15.5738 16.2345V17.5417H10.5137ZM16.4172 16.2345C16.4172 15.8878 16.5505 15.5553 16.7877 15.3102C17.025 15.065 17.3467 14.9273 17.6822 14.9273H20.2123C20.5478 14.9273 20.8695 15.065 21.1068 15.3102C21.344 15.5553 21.4773 15.8878 21.4773 16.2345V17.5417H16.4172V16.2345ZM8.82704 20.2912C8.82965 20.0129 8.89278 19.7388 9.01176 19.4892C9.13073 19.2395 9.30251 19.0207 9.51437 18.8489C9.83012 18.5715 10.23 18.4173 10.6445 18.4132H21.3466C21.761 18.4173 22.1609 18.5715 22.4767 18.8489L22.5231 18.8881C22.722 19.06 22.8823 19.2745 22.993 19.5167C23.1036 19.759 23.162 20.0233 23.164 20.2912V21.0276H8.82704V20.2912Z"
                          fill="#0DB254"
                        />
                      </svg>
                      <div className="d-flex flex-column">
                        <span className="_medium_title">bedroom</span>
                        <span className="app_medium_title">4 rooms</span>
                      </div>
                    </div>
                    <div className="d-flex align-items-center gap-2">
                      <div className="d-flex align-items-center gap-2">
                        <svg
                          width="39"
                          height="39"
                          viewBox="0 0 39 39"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <rect
                            x="0.927734"
                            y="0.899567"
                            width="37.7821"
                            height="37.7821"
                            rx="13.4936"
                            fill="#0DB254"
                            fillOpacity="0.05"
                          />
                          <g clipPath="url(#clip0_0_1)">
                            <path
                              d="M22.4049 14.8603C22.27 14.8603 22.1351 14.8088 22.0322 14.7059L21.7511 14.4248C21.5453 14.2189 21.5453 13.8852 21.7511 13.6793C21.9569 13.4735 22.2907 13.4735 22.4965 13.6793L22.7777 13.9605C23.1107 14.2935 22.8702 14.8603 22.4049 14.8603Z"
                              fill="#0DB254"
                            />
                            <path
                              d="M20.1559 15.1414C20.021 15.1414 19.8861 15.09 19.7832 14.987L19.5021 14.7059C19.2963 14.5 19.2963 14.1663 19.5021 13.9605C19.7079 13.7546 20.0417 13.7546 20.2475 13.9605L20.5286 14.2416C20.8617 14.5746 20.6212 15.1414 20.1559 15.1414Z"
                              fill="#0DB254"
                            />
                            <path
                              d="M22.4049 17.1092C22.27 17.1092 22.1351 17.0578 22.0322 16.9548L21.7511 16.6737C21.5453 16.4679 21.5453 16.1341 21.7511 15.9283C21.9569 15.7224 22.2907 15.7224 22.4965 15.9283L22.7777 16.2094C23.1107 16.5425 22.8702 17.1092 22.4049 17.1092Z"
                              fill="#0DB254"
                            />
                            <path
                              d="M29.1868 19.3581H12.2495C11.9584 19.3581 11.7224 19.1221 11.7224 18.831C11.7224 18.5399 11.9584 18.3039 12.2495 18.3039H12.882V11.7133C12.882 10.3893 13.9532 9.31595 15.279 9.31595C15.8328 9.31595 16.3729 9.50953 16.8 9.85987L17.131 10.1315C17.8718 9.69549 18.843 9.79508 19.4784 10.4304L20.2735 11.2255C20.4793 11.4314 20.4793 11.7651 20.2735 11.971L18.2857 13.9588C18.0799 14.1646 17.7461 14.1647 17.5403 13.9588C16.6962 13.1147 16.7486 13.1637 16.7451 13.1637C16.1325 12.551 16.018 11.626 16.4015 10.8966L16.1313 10.6749C15.8933 10.4797 15.5927 10.3714 15.2849 10.3702C14.5647 10.3637 13.9362 10.9492 13.9362 11.7133V18.3039C14.4762 18.3039 28.6518 18.3039 29.1868 18.3039C29.4779 18.3039 29.7139 18.5399 29.7139 18.831C29.7139 19.1221 29.4779 19.3581 29.1868 19.3581Z"
                              fill="#0DB254"
                            />
                            <path
                              d="M28.2754 20.4123L28.0508 21.6474C27.7166 23.4857 26.3526 24.9133 24.6186 25.3799V26.1401C24.6186 26.4312 24.3826 26.6672 24.0915 26.6672C23.8004 26.6672 23.5644 26.4312 23.5644 26.1401V25.5391C23.3999 25.5453 18.0174 25.5446 17.8718 25.5391V26.1401C17.8718 26.4312 17.6358 26.6672 17.3447 26.6672C17.0536 26.6672 16.8176 26.4312 16.8176 26.1401V25.3799C15.0837 24.9133 13.7196 23.4857 13.3854 21.6475L13.1609 20.4124H28.2754V20.4123Z"
                              fill="#0DB254"
                            />
                          </g>
                          <defs>
                            <clipPath id="clip0_0_1">
                              <rect
                                width="17.9915"
                                height="17.9915"
                                fill="white"
                                transform="matrix(-1 0 0 1 29.7139 8.99576)"
                              />
                            </clipPath>
                          </defs>
                        </svg>
                        <div className="d-flex flex-column">
                          <span className="_medium_title">nedroom</span>
                          <span className="app_medium_title">2 rooms</span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div className="app_card_heading d-flex justify-content-between">
                    <p className="d-flex align-items-center gap-1">
                      {app?.price} € <span>/ month</span>
                    </p>
                    <div className="d-flex gap-2">
                      <div className="edit-btn"></div>
                      <div className="close-btn"></div>
                    </div>
                  </div>
                </div>
              </div>
            </li>
          );
        })}
      </ul>
      <Modal title="My Modal" show={showModal} onHide={closeModal} size="lg">
        <div className="add_form">
          <h1>add new apparatement</h1>
          <form action="" onSubmit={handleSubmit} className="form_container">
            <label for="apartmentName">apartment Name :</label>
            <input
              type="text"
              id="apartmentName"
              name="apartmentName"
              value={formData.apartmentName}
              onChange={handleInputChange}
              placeholder="Enter Apartment Name"
              required
            />

            <div className="row">
              <div className="col-4">
                <label for="price">price:</label>
                <input
                  type="number"
                  id="price"
                  name="price"
                  value={formData.price}
                  onChange={handleInputChange}
                  placeholder="Enter Price"
                  required
                />
              </div>
              <div className="col-4">
                <label for="startDate">start date:</label>
                <input
                  type="date"
                  id="startDate"
                  name="startDate"
                  value={formData.startDate}
                  onChange={handleInputChange}
                  placeholder="Start date"
                  required
                />
              </div>
              <div className="col-4">
                <label for="endDate">end date:</label>
                <input
                  type="date"
                  id="endDate"
                  name="endDate"
                  value={formData.endDate}
                  onChange={handleInputChange}
                  placeholder="End date"
                  required
                />
              </div>
            </div>

            {/* <div className="row">
              <div className="col-4">
                <label for="first">add new price:</label>
                <input
                  type="number"
                  id="newPrice"
                  name="newPrice"
                  placeholder="Enter new price"
                  value={formData.newPrice}
                  onChange={handleInputChange}
                  // required
                />
              </div>
            </div> */}

            <label for="last">location:</label>
            <input
              type="text"
              id="location"
              name="location"
              value={formData.location}
              onChange={handleInputChange}
              placeholder="Enter location"
              required
            />

            <div className="row">
              <div className="col-6 col-md-3">
                <label for="first">bedroom:</label>
                <div className="_modal_counter border">
                  <button
                    className="minus"
                    onClick={() => handleCounterChange("bedroom", -1)}
                    disabled={formData.bedroom === 0}
                  >
                    -
                  </button>
                  <span>{formData.bedroom}</span>
                  <span
                    className="plus"
                    onClick={() => handleCounterChange("bedroom", 1)}
                  >
                    +
                  </span>
                </div>
              </div>
              <div className="col-6 col-md-3">
                <label for="first">bathroom:</label>
                <div className="_modal_counter border">
                  <button
                    className="minus"
                    onClick={() => handleCounterChange("bathroom", -1)}
                    disabled={formData.bathroom === 0}
                  >
                    -
                  </button>
                  <span>{formData.bathroom}</span>
                  <span
                    className="plus"
                    onClick={() => handleCounterChange("bathroom", 1)}
                  >
                    +
                  </span>
                </div>
              </div>
            </div>

            <div className="row">
              <label for="first">services:</label>
              <div className="__services col-5 col-md-3">
                <label for="myCheckbox" class="checkbox">
                  <input
                    class="checkbox__input"
                    type="checkbox"
                    id="myCheckbox"
                    checked={formData.parking}
                    onChange={() =>
                      setFormData({ ...formData, parking: !formData.parking })
                    }
                  />
                  <svg
                    class="checkbox__icon"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 22 22"
                  >
                    <rect
                      width="21"
                      height="21"
                      x=".5"
                      y=".5"
                      fill="#FFF"
                      stroke="#006F94"
                      rx="3"
                    />
                    <path
                      class="tick"
                      stroke="#6EA340"
                      fill="none"
                      stroke-linecap="round"
                      stroke-width="4"
                      d="M4 10l5 5 9-9"
                    />
                  </svg>
                  <span class="checkbox__label">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="16"
                      height="16"
                      fill="currentColor"
                      class="bi bi-car-front"
                      viewBox="0 0 16 16"
                    >
                      <path d="M4 9a1 1 0 1 1-2 0 1 1 0 0 1 2 0m10 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0M6 8a1 1 0 0 0 0 2h4a1 1 0 1 0 0-2zM4.862 4.276 3.906 6.19a.51.51 0 0 0 .497.731c.91-.073 2.35-.17 3.597-.17s2.688.097 3.597.17a.51.51 0 0 0 .497-.731l-.956-1.913A.5.5 0 0 0 10.691 4H5.309a.5.5 0 0 0-.447.276" />
                      <path d="M2.52 3.515A2.5 2.5 0 0 1 4.82 2h6.362c1 0 1.904.596 2.298 1.515l.792 1.848c.075.175.21.319.38.404.5.25.855.715.965 1.262l.335 1.679q.05.242.049.49v.413c0 .814-.39 1.543-1 1.997V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.338c-1.292.048-2.745.088-4 .088s-2.708-.04-4-.088V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.892c-.61-.454-1-1.183-1-1.997v-.413a2.5 2.5 0 0 1 .049-.49l.335-1.68c.11-.546.465-1.012.964-1.261a.8.8 0 0 0 .381-.404l.792-1.848ZM4.82 3a1.5 1.5 0 0 0-1.379.91l-.792 1.847a1.8 1.8 0 0 1-.853.904.8.8 0 0 0-.43.564L1.03 8.904a1.5 1.5 0 0 0-.03.294v.413c0 .796.62 1.448 1.408 1.484 1.555.07 3.786.155 5.592.155s4.037-.084 5.592-.155A1.48 1.48 0 0 0 15 9.611v-.413q0-.148-.03-.294l-.335-1.68a.8.8 0 0 0-.43-.563 1.8 1.8 0 0 1-.853-.904l-.792-1.848A1.5 1.5 0 0 0 11.18 3z" />
                    </svg>
                    <span>parking</span>
                  </span>
                </label>
              </div>
              <div className="__services col-5 col-md-3">
                <label for="myCheckbox_2" class="checkbox">
                  <input
                    class="checkbox__input"
                    type="checkbox"
                    id="myCheckbox_2"
                    checked={formData.food}
                    onChange={() =>
                      setFormData({ ...formData, food: !formData.food })
                    }
                  />
                  <svg
                    class="checkbox__icon"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 22 22"
                  >
                    <rect
                      width="21"
                      height="21"
                      x=".5"
                      y=".5"
                      fill="#FFF"
                      stroke="#006F94"
                      rx="3"
                    />
                    <path
                      class="tick"
                      stroke="#0DB254"
                      fill="none"
                      stroke-linecap="round"
                      stroke-width="4"
                      d="M4 10l5 5 9-9"
                    />
                  </svg>
                  <span class="checkbox__label">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="16"
                      height="16"
                      fill="currentColor"
                      class="bi bi-cup-straw"
                      viewBox="0 0 16 16"
                    >
                      <path d="M13.902.334a.5.5 0 0 1-.28.65l-2.254.902-.4 1.927c.376.095.715.215.972.367.228.135.56.396.56.82q0 .069-.011.132l-.962 9.068a1.28 1.28 0 0 1-.524.93c-.488.34-1.494.87-3.01.87s-2.522-.53-3.01-.87a1.28 1.28 0 0 1-.524-.93L3.51 5.132A1 1 0 0 1 3.5 5c0-.424.332-.685.56-.82.262-.154.607-.276.99-.372C5.824 3.614 6.867 3.5 8 3.5c.712 0 1.389.045 1.985.127l.464-2.215a.5.5 0 0 1 .303-.356l2.5-1a.5.5 0 0 1 .65.278M9.768 4.607A14 14 0 0 0 8 4.5c-1.076 0-2.033.11-2.707.278A3.3 3.3 0 0 0 4.645 5c.146.073.362.15.648.222C5.967 5.39 6.924 5.5 8 5.5c.571 0 1.109-.03 1.588-.085zm.292 1.756C9.445 6.45 8.742 6.5 8 6.5c-1.133 0-2.176-.114-2.95-.308a6 6 0 0 1-.435-.127l.838 8.03c.013.121.06.186.102.215.357.249 1.168.69 2.438.69s2.081-.441 2.438-.69c.042-.029.09-.094.102-.215l.852-8.03a6 6 0 0 1-.435.127 9 9 0 0 1-.89.17zM4.467 4.884s.003.002.005.006zm7.066 0-.005.006zM11.354 5a3 3 0 0 0-.604-.21l-.099.445.055-.013c.286-.072.502-.149.648-.222" />
                    </svg>
                    <span>food</span>
                  </span>
                </label>
              </div>
            </div>

            <div>
              <label htmlFor="pictures">Pictures:</label>
              <div className="row">
                <div className="col">
                  <div className="form-group ">
                    <label>Choose Images</label>
                    <input
                      type="file"
                      id="pictures"
                      className="form-control"
                      multiple
                      onChange={handleImageChange}
                      required
                    />
                  </div>
                  <div
                    className={`img-thumbs ${
                      formData.pictures.length > 0 ? "" : "img-thumbs-hidden"
                    }`}
                    id="img-preview"
                  >
                    {formData.pictures.map((image) => (
                      <div key={image.id} className="wrapper-thumb">
                        <img
                          src={image.url}
                          alt="Preview"
                          className="img-preview-thumb"
                        />
                        <div
                          className="remove-btn"
                          onClick={() => handleRemoveImage(image.id)}
                        >
                          x
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>

            <div>
              <label>Description</label>
              <textarea
                className="form-control"
                rows="3"
                name="description"
                value={formData.description}
                onChange={handleInputChange}
                placeholder="Enter description"
                required
              ></textarea>
            </div>

            <div className="wrap">
              <button type="submit" onclick="solve()">
                Submit
              </button>
            </div>
          </form>
        </div>
      </Modal>
    </>
  );
}
