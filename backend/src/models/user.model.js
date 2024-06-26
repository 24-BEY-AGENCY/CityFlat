import mongoose from "mongoose";
const { Schema, model } = mongoose;
import { ROLE } from "../models/user.enums.js";

const UserSchema = new Schema(
  {
    googleID: {
      type: String,
      required: false,
    },
    name: {
      type: String,
      required: true,
      minlength: 6,
      maxlength: 25,
      validate: {
        validator: function (v) {
          return /^[a-zA-Z ]+$/.test(v);
        },
        message: "Name should only contain alphabets and spaces.",
      },
    },
    password: {
      type: String,
      required: true,
      minlength: 8,
      maxlength: 100,
      validate: {
        validator: function (v) {
          return /^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}$/.test(
            v
          );
        },
        message:
          "Password should be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character.",
      },
    },
    email: {
      type: String,
      required: true,
      unique: true,
      validate: {
        validator: function (v) {
          return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(v);
        },
        message: "Email is not valid.",
      },
    },
    number: {
      type: String,
      required: false,
      // unique: true,
    },
    address: {
      type: String,
      required: false,
      minlength: 0,
      maxlength: 50,
    },
    isVerified: { type: Boolean, default: false },
    verifCode: String,
    verificationCode: {
      type: String,
    },
    birthdate: {
      type: Date,
      required: false,
      validate: {
        validator: function (v) {
          return v <= Date.now();
        },
        message: "Birth date cannot be in the future.",
      },
    },
    role: {
      type: String,
      enum: [ROLE.ADMIN, ROLE.USER],
      default: ROLE.USER,
    },
    stripeCustomerID: {
      type: String,
      required: false,
    },
    cards: [{ type: Schema.Types.ObjectId, ref: "Card" }],
    img: {
      type: String,
      required: false,
      default:
        "https://res.cloudinary.com/dvjvlobqp/image/upload/v1683540045/CityFlat-assets/icons/blank-profile-picture-g91ef0370b_1280_pqkj43.png",
    },
    reservations: [
      { type: Schema.Types.ObjectId, ref: "Reservation", required: false },
    ],
    wishlist: [
      { type: Schema.Types.ObjectId, ref: "Appartment", required: false },
    ],
  },
  { timestamps: true }
);

//a middleware for user input control !
UserSchema.pre("save", async function (next) {
  try {
    // validate name field
    if (this.isModified("name")) {
      const nameRegex = /^[a-zA-Z ]+$/;
      // const nameRegex = /^[a-zA-Z]{1,15}$/;
      if (!nameRegex.test(this.name)) {
        throw new Error(
          "Name should only contain alphabets or spaces, no numbers, and should be between 1 to 25 characters long."
        );
      }
    }

    // validate password field
    if (this.isModified("password")) {
      const passwordRegex =
        /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?!.*\s).{8,100}$/;
      if (!passwordRegex.test(this.password)) {
        throw new Error(
          "Password should be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character (@#$%^&+=)."
        );
      }
    }

    // validate email field
    if (this.isModified("email")) {
      const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
      if (!emailRegex.test(this.email)) {
        throw new Error("Email is not valid.");
      }
    }

    // validate number field
    if (this.isModified("number")) {
      if (!this.number) {
        throw new Error("Number field cannot be empty.");
      }
    }

    // validate birthdate field
    /*     if (this.isModified("BirthDate")) {
      const currentDate = new Date();
      const inputDate = new Date(this.BirthDate);
      if (inputDate > currentDate) {
        throw new Error("Birthdate cannot be in the future.");
      }
    } */

    next();
  } catch (err) {
    next(err);
  }
});

export default model("User", UserSchema);
