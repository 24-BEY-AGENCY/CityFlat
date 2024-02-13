import { useState } from "react";

// Custom hook for managing modal state
export const useModal = () => {
  const [showModal, setShowModal] = useState(false);

  const openModal = () => {
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
  };
  return { showModal, openModal, closeModal };
};
