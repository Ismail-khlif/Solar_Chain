import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';

import { logo, sun } from '../assets';
import { navlinks } from '../constants';

const Icon = ({ styles, name, imgUrl, isActive, disabled, handleClick }) => (
    <div
        className={`w-[48px] h-[48px] rounded-[10px] ${
            isActive && isActive === name ? 'bg-[#2c2f32]' : ''
        } flex justify-center items-center ${!disabled ? 'cursor-pointer' : ''} ${
            styles
        }`}
        onClick={handleClick}
    >
        {!isActive ? (
            <img src={imgUrl} alt="fund_logo" className="w-[50%] h-[50%]" />
        ) : (
            <img
                src={imgUrl}
                alt="fund_logo"
                className={`w-[50%] h-[50%] ${isActive !== name ? 'grayscale' : ''}`}
            />
        )}
    </div>
);

const Sidebar = () => {
    const navigate = useNavigate();
    const [isActive, setIsActive] = useState('dashboard');

    return (
        <div className="flex justify-between items-start flex-col sticky top-5 h-[93vh] bg-black">
            <div className="mt-4">
                <Link to="/">
                    <div className="w-[52px] h-[52px] bg-[#2c2f32]">
                        <img src={logo} alt="fund_logo" className="w-full h-full" />
                    </div>
                </Link>
            </div>
            <div style={{ height: '20px' }} />
            <div style={{ height: '20px' }} />
            <div style={{ height: '20px' }} />

            <div className="mt-4">
                {navlinks.map((link) => (
                    <Icon
                        key={link.name}
                        {...link}
                        isActive={isActive}
                        handleClick={() => {
                            if (!link.disabled) {
                                setIsActive(link.name);
                                navigate(link.link);
                            }
                        }}
                    />
                ))}
                <Icon
                    styles={{ background: '#1c1c24', boxShadow: '0px 2px 4px rgba(0, 0, 0, 0.15)' }}
                    imgUrl={sun}
                    handleClick={() => {
                        // Handle sun icon click here
                    }}
                />
            </div>
        </div>
    );
};

export default Sidebar;
