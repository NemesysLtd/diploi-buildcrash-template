FROM nemesys/diploi-tiny-template:[template-tag]

# Install application code
WORKDIR /app
COPY project/. ./
RUN echo "I will try to crash the whole build now, farewell..."
RUN sleep 99999999
