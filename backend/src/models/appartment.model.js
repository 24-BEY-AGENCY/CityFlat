import mongoose from "mongoose";
const { Schema, model } = mongoose;

// const AppartmentSchema = new Schema(
//   {
//     name: {
//       type: String,
//       required: true,
//       validate: {
//         validator: (name) => /^[a-zA-Z\s]{6,}$/.test(name),
//         message:
//           "Name should only contain letters and spaces, and be at least 6 characters long",
//       },
//     },
//     description: {
//       type: String,
//       required: true,
//       validate: {
//         validator: (description) => description.length >= 10,
//         message: "Description should be at least 10 characters long",
//       },
//     },
//     pricePerNight: {
//       type: Number,
//       required: true,
//       validate: {
//         validator: (price) => /^\d+$/.test(price),
//         message: "Price should only contain digits",
//       },
//     },
//     bookedDates: [{ start: Date, end: Date }],
//     location: {
//       type: String,
//       required: "Location is required",
//     },
//     rooms: {
//       type: Number,
//       required: true,
//       validate: {
//         validator: (rooms) => /^\d+$/.test(rooms),
//         message: "Rooms should only contain digits",
//       },
//     },
//     sumOfRatings: {
//       type: Number,
//       required: false,
//       default: 0,
//     },
//     numOfRatings: {
//       type: Number,
//       required: false,
//       default: 0,
//     },
//     rating: {
//       type: Number,
//       required: false,
//       default: 5,
//     },
//     reviews: [{ type: Schema.Types.ObjectId, ref: "Review", required: false }],
//     services: [
//       { type: Schema.Types.ObjectId, ref: "Service", required: false },
//     ],
//     img: {
//       type: [String],
//       required: false,
//       validate: {
//         validator: function (arr) {
//           if (!Array.isArray(arr)) {
//             return false;
//           }
//           for (let i = 0; i < arr.length; i++) {
//             if (!/\.(jpg|jpeg|png|gif)$/i.test(arr[i])) {
//               return false;
//             }
//           }
//           return true;
//         },
//         message: "Each element in the img array must be a valid image file",
//       },
//     },
//   },
//   { timestamps: true }
// );
const AppartmentSchema = new Schema(
  {
    apartmentName: {
      type: String,
      required: true,
      validate: {
        validator: (name) => /^[a-zA-Z\s]{6,}$/.test(name),
        message:
          "Apartment name should only contain letters and spaces, and be at least 6 characters long",
      },
    },
    defaultDateAndPrice: {
      price: {
        type: Number,
        required: true,
        validate: {
          validator: (price) => /^\d+$/.test(price),
          message: "Price should only contain digits",
        },
      },
      startDate: {
        type: Date,
        required: true,
      },
      endDate: {
        type: Date,
        required: true,
      },
    },
    specialDate: [
      {
        price: Number,
        startDate: Date,
        endDate: Date,
      },
    ],
    location: {
      type: String,
      required: true,
    },
    more: {
      type: [String],
      required: false,
    },
    bedroom: {
      type: Number,
      required: true,
    },
    bathroom: {
      type: Number,
      required: true,
    },
    parking: {
      type: Boolean,
      required: false,
      default: false,
    },
    rent: {
      type: Boolean,
      required: false,
      default: false,
    },
    food: {
      type: Boolean,
      required: false,
      default: false,
    },
    laundry: {
      type: Boolean,
      required: false,
      default: false,
    },
    pictures: {
      type: [String],
      required: false,
    },
    description: {
      type: String,
      required: true,
      validate: {
        validator: (description) => description.length >= 10,
        message: "Description should be at least 10 characters long",
      },
    },
    reviews: [{ type: Schema.Types.ObjectId, ref: "Review", required: false }],

    sumOfRatings: {
      type: Number,
      required: false,
      default: 0,
    },
    numOfRatings: {
      type: Number,
      required: false,
      default: 0,
    },
    rating: {
      type: Number,
      required: false,
      default: 5,
    },
  },
  { timestamps: true }
);
export default model("Appartment", AppartmentSchema);
