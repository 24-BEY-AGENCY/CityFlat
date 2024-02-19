import { useState } from "react";

// Custom hook for managing modal state
export const useModal = () => {
  const [showModal, setShowModal] = useState(false);
  const [showModal2, setShowModal2] = useState(false);

  const openModal = () => {
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
  };

  const openModal2 = () => {
    setShowModal2(true);
  };

  const closeModal2 = () => {
    setShowModal2(false);
  };
  return {
    showModal,
    openModal,
    closeModal,
    showModal2,
    openModal2,
    closeModal2,
  };
};
