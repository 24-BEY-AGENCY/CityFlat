import mongoose from "mongoose";
import apartmentDb from "../models/appartment.model.js";
import { validationResult } from "express-validator";
import orderModel from "../models/order.model.js";
import userDb from "../models/user.model.js";

//add apartment
export function httpAddAppartment(req, res) {
  if (!validationResult(req).isEmpty()) {
    res.status(400).json({ error: validationResult(req).array() });
  } else {
    apartmentDb
      .findOne({})
      .or([{ apartmentName: req.body.apartmentName }])
      .then((exists) => {
        if (exists) {
          res.status(409).json({ message: "Apartment exists already!" });
        } else {
          const newAppartment = req.body;

          if (req.file) {
            newAppartment.img = "../public/images/" + req.file.filename;
          }

          apartmentDb
            .create(newAppartment)
            .then((result) => {
              findOneAppartByFilter(result._id)
                .then((register) =>
                  res.status(201).json(appartFormat(register))
                )
                .catch((err) => res.status(500).json({ error: err.message }));
            })
            .catch((err) => res.status(500).json({ error: err.message }));
        }
      })
      .catch((err) => res.status(500).json({ error: err.message }));
  }
}
// export function httpAddAppartment(req, res) {
//   if (!validationResult(req).isEmpty()) {
//     res.status(400).json({ error: validationResult(req).array() });
//   } else {
//     apartmentDb
//       .findOne({})
//       .or([{ apartmentName: req.body.apartmentName }])
//       .then((exists) => {
//         if (exists) {
//           res.status(409).json({ message: "Apartment already exists!" });
//         } else {
//           const newAppartment = req.body;

//           if (req.files && req.files.length > 0) {
//             newAppartment.pictures = req.files.map((file) => {
//               return "../public/images/" + file.filename;
//             });
//           }
//           apartmentDb
//             .create(newAppartment)
//             .then((result) => {
//               findOneAppartByFilter(result._id)
//                 .then((register) =>
//                   res.status(201).json(appartFormat(register))
//                 )
//                 .catch((err) => res.status(500).json({ error: err.message }));
//             })
//             .catch((err) => res.status(500).json({ error: err.message }));
//         }
//       })
//       .catch((err) => res.status(500).json({ error: err.message }));
//   }
// }

//get all appartments
export function httpGetAllApparts(req, res) {
  apartmentDb
    .find()
    // .populate("reviews")
    .then((apparts) => {
      res.status(200).json(appartsListFormat(apparts));
    })
    .catch((err) => res.status(500).json({ error: err.message }));
}

//get all appartments with the property isWishlisted
export function httpGetAllAppartsWishlisted(req, res) {
  const userId = req.user.id;
  console.log(userId);
  apartmentDb
    .find()
    .populate("reviews")
    .then((apparts) => {
      userDb.findOne({ _id: userId }, (err, user) => {
        if (err) {
          return res.status(500).json({ error: err.message });
        }

        if (!user) {
          return res.status(404).json({ error: "User not found" });
        }

        const updatedApparts = apparts.map((apartment) => {
          const isWishlist = user.wishlist.includes(apartment._id.toString());
          return { ...apartment.toObject(), isWishlist };
        });

        res.status(200).json(appartsIsWishlistedListFormat(updatedApparts));
      });
    })
    .catch((err) => res.status(500).json({ error: err.message }));
}

//get user's ordered appartments with the property isWishlisted
export function getRentalsWishlisted(req, res) {
  const userId = req.user.id;
  const rentals = [];

  orderModel.find({ User: userId }, (err, orders) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }

    const apartmentIds = orders.map((order) => order.appartment.toString());

    apartmentDb
      .find({ _id: { $in: apartmentIds } })
      .then((apparts) => {
        userDb.findOne({ _id: userId }, (err, user) => {
          if (err) {
            return res.status(500).json({ error: err.message });
          }

          if (!user) {
            return res.status(404).json({ error: "User not found" });
          }

          const updatedApparts = apparts.map((apartment) => {
            const isWishlist = user.wishlist.includes(apartment._id.toString());
            return { ...apartment.toObject(), isWishlist };
          });

          rentals.push(...updatedApparts);

          res.status(200).json(appartsIsWishlistedListFormat(rentals));
        });
      })
      .catch((err) => res.status(500).json({ error: err.message }));
  });
}

//get one appartment
export function httpGetOneAppartment(req, res) {
  findOneAppartByFilter(req.params.param)
    .then((foundAppart) => {
      if (!foundAppart) {
        res.status(404).json({ message: "Appartment not found!" });
      } else {
        res.status(200).json(appartFormat(foundAppart));
      }
    })
    .catch((err) => res.status(500).json({ error: err.message }));
}

//get one appartment with wishlist property
export function httpGetOneAppartmentWishlist(req, res) {
  const userId = req.user.id;
  findOneAppartByFilter(req.params.id)
    .then((foundAppart) => {
      if (!foundAppart) {
        res.status(404).json({ message: "Appartment not found!" });
      } else {
        userDb.findOne({ _id: userId }, (err, user) => {
          if (err) {
            return res.status(500).json({ error: err.message });
          }

          if (!user) {
            return res.status(404).json({ error: "User not found" });
          }

          const isWishlist = user.wishlist.includes(foundAppart._id.toString());
          foundAppart.isWishlist = isWishlist;

          res.status(200).json(appartWishlistFormat(foundAppart));
        });
      }
    })
    .catch((err) => res.status(500).json({ error: err.message }));
}

//get one rental with wishlist property
export function getOneRentalWishlist(req, res) {
  const userId = req.user.id;
  findOneAppartByFilter(req.params.id)
    .then((foundAppart) => {
      if (!foundAppart) {
        res.status(404).json({ message: "Appartment not found!" });
      } else {
        orderModel
          .find({ User: userId, appartment: foundAppart._id })
          .sort({ createdAt: -1 })
          .exec((err, orders) => {
            if (err) {
              return res.status(500).json({ error: err.message });
            }

            const isRented = orders.length > 0;
            let state = null;
            if (isRented) {
              state = orders[0].state;
            }

            userDb.findOne({ _id: userId }, (err, user) => {
              if (err) {
                return res.status(500).json({ error: err.message });
              }

              if (!user) {
                return res.status(404).json({ error: "User not found" });
              }

              const isWishlist = user.wishlist.includes(
                foundAppart._id.toString()
              );
              foundAppart.isWishlist = isWishlist;
              foundAppart.state = state;

              res.status(200).json(appartWishlistFormat(foundAppart));
            });
          });
      }
    })

    .catch((err) => res.status(500).json({ error: err.message }));
}

//Update one appartment with filter
export function httpUpdateOneAppartment(req, res) {
  if (!validationResult(req).isEmpty()) {
    res.status(400).json({ error: validationResult(req).array() });
  } else {
    const newValues = req.body;

    findOneAppartByFilter(req.params.id)
      .then((foundAppart) => {
        if (!foundAppart) {
          res.status(404).json({ message: "Appartment not found!" });
        } else {
          //newValues.isVerified = foundAppart.isVerified;
          //newValues.isBanned = foundAppart.isBanned;
          apartmentDb
            .findByIdAndUpdate(foundAppart._id, newValues)
            .then((result) => {
              apartmentDb
                .findById(result._id)
                .then((updated) => {
                  res.status(200).json(appartFormat(updated));
                })
                .catch((err) => res.status(500).json({ error: err.message }));
            })
            .catch((err) => res.status(500).json({ error: err.message }));
        }
      })
      .catch((err) => res.status(500).json({ error: err.message }));
  }
}

//remove
export async function removeApartmentFromOrders(apartmentId) {
  try {
    const result = await orderModel.updateMany(
      { appartment: apartmentId },
      { $unset: { appartment: 1 } }
    );
    return result;
  } catch (err) {
    console.error(err);
    return null;
  }
}

//delete one appartment with filter
export function httpDeleteOneAppart(req, res) {
  findOneAppartByFilter(req.params.id)
    .then((foundAppart) => {
      if (!foundAppart) {
        res.status(404).json({ error: "Appartment not found!" });
      } else {
        removeApartmentFromOrders(foundAppart._id);
        apartmentDb
          .findByIdAndDelete(foundAppart._id)
          .then((result) => {
            res.status(200).json({
              message: `${foundAppart.name} deleted successfully`,
            });
          })
          .catch((err) => res.status(500).json({ error: err.message }));
      }
    })
    .catch((err) => res.status(500).json({ error: err.message }));
}

/// get all the available dates for this appartment
export async function getAvailableDates(apartmentId, startDate, endDate) {
  const apartment = await apartmentDb.findById(apartmentId);
  const bookedDates = apartment.bookedDates || [];
  const overlappingDates = bookedDates.filter((bookedDate) => {
    return startDate < bookedDate.end && endDate > bookedDate.start;
  });

  const availableDates = [];

  // if there are no overlapping dates, add the selected range as available
  if (overlappingDates.length === 0) {
    availableDates.push({ start: startDate, end: endDate });
  } else {
    // if there are overlapping dates, calculate the available dates
    let lastEndDate = startDate;

    overlappingDates.forEach((bookedDate) => {
      if (bookedDate.start > lastEndDate) {
        availableDates.push({ start: lastEndDate, end: bookedDate.start });
      }
      lastEndDate = bookedDate.end;
    });

    if (lastEndDate < endDate) {
      availableDates.push({ start: lastEndDate, end: endDate });
    }
  }

  return availableDates;
}

export async function updateBookedDates(
  apartmentId,
  checkInDate,
  checkOutDate,
  res
) {
  try {
    const apartment = await apartmentDb.findById(apartmentId);

    if (!apartment) {
      throw new Error("Apartment not found");
    }

    // Convert check-in and check-out dates to ISO strings
    const isoCheckInDate = String(checkInDate);
    const isoCheckOutDate = String(checkOutDate);

    // Check if the new booked dates overlap with any existing booked dates
    const overlap = apartment.bookedDates.some(({ start, end }) => {
      const existingStart = new Date(start);
      const existingEnd = new Date(end);
      const newStart = new Date(isoCheckInDate);
      const newEnd = new Date(isoCheckOutDate);

      return (
        (newStart >= existingStart && newStart < existingEnd) ||
        (newEnd > existingStart && newEnd <= existingEnd) ||
        (newStart <= existingStart && newEnd >= existingEnd)
      );
    });

    // If there is overlap, return a conflict response
    if (overlap) {
      return;
    }

    // Add the booked dates to the apartment document
    apartment.bookedDates.push({ start: isoCheckInDate, end: isoCheckOutDate });

    // Remove any booked dates that have already passed
    const today = new Date();
    apartment.bookedDates = apartment.bookedDates.filter(
      ({ end }) => new Date(end) > today
    );

    // Save the apartment document
    await apartment.save();

    // Return a success response
    //return res.status(200).json(apartment);
  } catch (error) {
    console.error(error);
    // Return an error response
  }
}

export async function findOneAppartByFilter(appartFilter) {
  var appartId = null;
  if (mongoose.Types.ObjectId.isValid(appartFilter)) {
    appartId = appartFilter;
  }
  return await apartmentDb.findOne({ _id: appartId });
  // .populate("services")
  // .populate("reviews");
}
//appartment object format to get all appartments
export function appartsListFormat(apparts) {
  let foundApparts = [];
  apparts.forEach((appartment) => {
    foundApparts.push(appartFormat(appartment));
  });
  return foundApparts;
}

//apartment object format to get all appartments whether wishlisted or not
export function appartsIsWishlistedListFormat(apparts) {
  let foundApparts = [];
  apparts.forEach((apartment) => {
    foundApparts.push({ ...apartment, isWishlist: apartment.isWishlist });
  });
  console.log(foundApparts);
  return foundApparts;
}

//Appartment format
// export function appartFormat(appartment) {
//   return {
//     id: appartment._id,
//     name: appartment.name,
//     description: appartment.description,
//     pricePerNight: appartment.pricePerNight,
//     bookedDates: appartment.bookedDates,
//     location: appartment.location,
//     rooms: appartment.rooms,
//     reviews: appartment.reviews,
//     services: appartment.services,
//     img: appartment.img,
//     rating: appartment.rating,
//     sumOfRatings: appartment.sumOfRatings,
//     numOfRatings: appartment.numOfRatings,
//   };
// }

export function appartFormat(appartment) {
  return {
    id: appartment._id,
    apartmentName: appartment.apartmentName,
    bathroom: appartment.bathroom,
    bedroom: appartment.bedroom,
    defaultDateAndPrice: appartment.defaultDateAndPrice,
    description: appartment.description,
    food: appartment.food,
    rent: appartment.rent,
    id: appartment._id,
    laundry: appartment.laundry,
    location: appartment.location,
    more: appartment.more,
    parking: appartment.parking,
    pictures: appartment.pictures,
    specialDate: appartment.specialDate,
    reviews: appartment.reviews,
    rating: appartment.rating,
    sumOfRatings: appartment.sumOfRatings,
    numOfRatings: appartment.numOfRatings,
    isWishlist: appartment.isWishlist,
    // bookedDates: appartment.bookedDates,
  };
}

//Appartment with wishlist property format
export function appartWishlistFormat(appartment) {
  return {
    _id: appartment._id,
    apartmentName: appartment.apartmentName,
    bathroom: appartment.bathroom,
    bedroom: appartment.bedroom,
    defaultDateAndPrice: appartment.defaultDateAndPrice,
    defaultPrice: appartment.defaultPrice,
    bookedDates: appartment.bookedDates,

    description: appartment.description,
    food: appartment.food,
    rent: appartment.rent,
    laundry: appartment.laundry,
    location: appartment.location,
    more: appartment.more,
    parking: appartment.parking,
    pictures: appartment.pictures,
    specialDate: appartment.specialDate,
    reviews: appartment.reviews,
    rating: appartment.rating,
    sumOfRatings: appartment.sumOfRatings,
    numOfRatings: appartment.numOfRatings,
    isWishlist: appartment.isWishlist,
    state: appartment.state,
  };
}
