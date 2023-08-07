import React from 'react';
import Image from 'next/image';

export default function Icon ({ styles,imgUrl,disabled,handleClick,isActive,name })  {
  return (
    <div className={`w-8 relative h-8 rounded-[10px] ${isActive &&isActive===name? 'bg-[#2c2f32]':null} flex justify-center items-center ${!disabled &&'cursor-pointer'} ${styles}`} onClick={handleClick}>
     {!isActive? <Image className='w-1/2 h-1/2' src={imgUrl} alt={'fund_logo'} width={16} height={16}/>: 
     <Image src={imgUrl} alt={'fund_logo'}  className={`w-3/4 h-3/4 ${isActive!==name?'grayscale':null}`}/>
     }
    </div>
  );
};
