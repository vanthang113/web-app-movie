import React, { FunctionComponent, ReactNode } from 'react';

type MessageProps = {
  children: ReactNode;
};

const Message: FunctionComponent<MessageProps> = ({ children }) => {
    return (
        <div className='flex items-center bg-blue-500 text-white text-sm font-bold px-4 py-3' role="alert">
            <p>{children}</p>
        </div>
    );
}

export default Message;
